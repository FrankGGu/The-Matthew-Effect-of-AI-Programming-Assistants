-module(long_pressed_name).
-export([is_long_pressed_name/2]).

is_long_pressed_name(Name, Typed) ->
    is_long_pressed_name(Name, Typed, 1, 1).

is_long_pressed_name([], [], _, _) ->
    true;
is_long_pressed_name([], _, _, _) ->
    false;
is_long_pressed_name(_, [], _, _) ->
    false;
is_long_pressed_name([H|T], [H|T2], I, J) ->
    is_long_pressed_name(T, T2, I+1, J+1);
is_long_pressed_name([H|T], [H2|T2], I, J) ->
    if
        H == H2 ->
            is_long_pressed_name(T, T2, I+1, J+1);
        true ->
            is_long_pressed_name([H|T], T2, I, J+1)
    end.