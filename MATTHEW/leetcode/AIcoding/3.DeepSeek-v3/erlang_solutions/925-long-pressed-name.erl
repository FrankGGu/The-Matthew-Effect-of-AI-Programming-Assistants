-spec is_long_pressed_name(Name :: unicode:unicode_binary(), Typed :: unicode:unicode_binary()) -> boolean().
is_long_pressed_name(Name, Typed) ->
    is_long_pressed_name(binary_to_list(Name), binary_to_list(Typed)).

is_long_pressed_name([], []) -> true;
is_long_pressed_name([], [_|_]) -> false;
is_long_pressed_name([_|_], []) -> false;
is_long_pressed_name([H|T1], [H|T2]) ->
    is_long_pressed_name(T1, T2);
is_long_pressed_name([H1|T1], [H2|T2]) when H1 =/= H2 ->
    case T2 of
        [H2|Rest] -> is_long_pressed_name([H1|T1], Rest);
        _ -> false
    end.