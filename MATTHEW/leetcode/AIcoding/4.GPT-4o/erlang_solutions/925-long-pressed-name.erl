-module(solution).
-export([is_long_pressed_name/2]).

is_long_pressed_name(Name, Typed) ->
    is_long_pressed_name(Name, Typed, 0, 0).

is_long_pressed_name([], []) -> true;
is_long_pressed_name([], _Typed) -> false;
is_long_pressed_name(_Name, []) -> false;
is_long_pressed_name(Name, Typed) ->
    is_long_pressed_name(Name, Typed, 0, 0).

is_long_pressed_name(Name, Typed, I, J) ->
    case {lists:nth(I + 1, Name), lists:nth(J + 1, Typed)} of
        {undefined, _} -> false;
        {_, undefined} -> true;
        {N, T} when N =:= T -> is_long_pressed_name(Name, Typed, I + 1, J + 1);
        {N, T} when N =:= lists:nth(J + 1, Typed) -> is_long_pressed_name(Name, Typed, I, J + 1);
        {_, _} -> false
    end.