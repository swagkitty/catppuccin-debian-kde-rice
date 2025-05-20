#!/bin/bash

# Exit on any error
set -e

echo "🌙 Starting Catppuccin KDE Mocha + Lavender Rice Setup..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install -y kitty fastfetch sddm git curl unzip qt5-style-kvantum qt5ct qt6ct kde-style-breeze

# Create config directories
mkdir -p ~/.config/kitty
mkdir -p ~/.config/fastfetch

# Clone and apply Catppuccin themes
echo "🎨 Downloading Catppuccin themes..."

# KDE color scheme
mkdir -p ~/.local/share/color-schemes
curl -Lo ~/.local/share/color-schemes/Catppuccin-MochaLavender.colors https://raw.githubusercontent.com/catppuccin/kde/main/src/catppuccin-mocha-lavender.colors

# Plasma style
mkdir -p ~/.local/share/plasma/desktoptheme
curl -Lo catppuccin-kde.zip https://github.com/catppuccin/kde/releases/latest/download/catppuccin-kde.zip
unzip -o catppuccin-kde.zip -d ~/.local/share/plasma/desktoptheme/
rm catppuccin-kde.zip

# Kvantum theme
mkdir -p ~/.config/Kvantum
curl -Lo catppuccin-kvantum.zip https://github.com/catppuccin/kvantum/releases/latest/download/Catppuccin-Mocha-Lavender.zip
unzip -o catppuccin-kvantum.zip -d ~/.config/Kvantum/
rm catppuccin-kvantum.zip

# Kitty config
cat > ~/.config/kitty/kitty.conf <<EOF
font_family      FiraCode Nerd Font
font_size        11
background       #1e1e2e
foreground       #cdd6f4
cursor           #f5e0dc
color0           #45475a
color1           #f38ba8
color2           #a6e3a1
color3           #f9e2af
color4           #89b4fa
color5           #f5c2e7
color6           #94e2d5
color7           #bac2de
EOF

# Fastfetch config
fastfetch --gen-config
sed -i 's/"titleColor": .*/"titleColor": "lavender",/' ~/.config/fastfetch/config.jsonc

# SDDM theme setup
echo "💡 Setting up SDDM theme..."
sudo git clone https://github.com/catppuccin/sddm.git /usr/share/sddm/themes/catppuccin
sudo cp -r /usr/share/sddm/themes/catppuccin/src/* /usr/share/sddm/themes/catppuccin/
sudo sed -i 's/^Current=.*/Current=catppuccin/' /etc/sddm.conf || echo -e "[Theme]\nCurrent=catppuccin" | sudo tee -a /etc/sddm.conf

echo "✅ Done! Reboot to apply changes."
