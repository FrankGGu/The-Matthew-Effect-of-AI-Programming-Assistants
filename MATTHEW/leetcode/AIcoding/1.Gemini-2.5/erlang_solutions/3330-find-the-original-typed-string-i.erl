-module(solution).
-export([is_long_pressed_name/2]).

is_long_pressed_name(Name, Typed) ->
    is_long_pressed_name(Name, Typed, none).

is_long_pressed_name([], [], _PrevChar) ->
    true;
is_long_pressed_name([], [Th | Tt], {'char', PrevChar}) when Th == PrevChar ->
    is_long_pressed_name([], Tt, {'char', PrevChar});
is_long_pressed_name([], _Typed, _PrevChar) ->
    false;

is_long_pressed_name([Nh | Nt], [Th | Tt], _PrevChar) when Nh == Th ->
    is_long_pressed_name(Nt, Tt, {'char', Nh});
is_long_pressed_name([Nh | Nt], [Th | Tt], {'char', PrevChar}) when Th == PrevChar ->
    is_long_pressed_name([Nh | Nt], Tt, {'char', PrevChar});
is_long_pressed_name(_Name, _Typed, _PrevChar) ->
    false.