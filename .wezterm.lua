-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices


-- For example, changing the color scheme:

local mycolor_dark = wezterm.color.get_builtin_schemes()['rose-pine-moon']
local mycolor_light = wezterm.color.get_builtin_schemes()['rose-pine-dawn']

-- selection_bg is used as the conversion text, so make it different from conposition text for visibility
mycolor_dark.selection_bg = 'silver'
mycolor_light.selection_bg = 'gray'

config.color_schemes = {
    ['My Color Dark'] = mycolor_dark,
    ['My Color Light'] = mycolor_light,
}


local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'My Color Dark'
  else
    return 'My Color Light'
  end
end

wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

config.font = wezterm.font_with_fallback({ "JetBrains Mono", "Hiragino Maru Gothic Pro" })

config.font_size = 13

config.enable_kitty_graphics = true

-- config.window_background_opacity = 0.95
-- config.text_background_opacity = 0.8


config.window_padding = {
    left = '0',
    right = '0',
    top = '0',
    bottom = '0',
}

config.warn_about_missing_glyphs = false

config.tab_bar_at_bottom = true

local act = wezterm.action
config.keys = {
    { key = 'Tab',       mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'Enter',     mods = 'ALT',        action = act.ToggleFullScreen },
    { key = '\"',        mods = 'SHIFT|CTRL', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = '%',         mods = 'SHIFT|CTRL', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = ')',         mods = 'ALT',        action = act.ResetFontSize },
    { key = '+',         mods = 'ALT',        action = act.IncreaseFontSize },
    { key = '-',         mods = 'ALT',        action = act.DecreaseFontSize },
    { key = '0',         mods = 'ALT',        action = act.ResetFontSize },
    { key = '1',         mods = 'ALT',        action = act.ActivateTab(0) },
    { key = '2',         mods = 'ALT',        action = act.ActivateTab(1) },
    { key = '3',         mods = 'ALT',        action = act.ActivateTab(2) },
    { key = '4',         mods = 'ALT',        action = act.ActivateTab(3) },
    { key = '5',         mods = 'ALT',        action = act.ActivateTab(4) },
    { key = '6',         mods = 'ALT',        action = act.ActivateTab(5) },
    { key = '7',         mods = 'ALT',        action = act.ActivateTab(6) },
    { key = '8',         mods = 'ALT',        action = act.ActivateTab(7) },
    { key = '9',         mods = 'ALT',        action = act.ActivateTab(-1) },
    { key = 'UpArrow',   mods = 'SHIFT',      action = act.ScrollToPrompt(-1) },
    { key = 'DownArrow', mods = 'SHIFT',      action = act.ScrollToPrompt(1) },
    { key = 'Z',         mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
    { key = 'Enter',     mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
    { key = 't',         mods = 'ALT',        action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'h',         mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
    { key = 'l',         mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = 'k',         mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
    { key = 'j',         mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
    { key = 'w',         mods = 'SUPER', action = act.CloseCurrentPane { confirm = true } },
}

return config
