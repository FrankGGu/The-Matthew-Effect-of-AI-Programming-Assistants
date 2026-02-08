-spec can_make_arithmetic_progression(Arr :: [integer()]) -> boolean().
can_make_arithmetic_progression(Arr) ->
    Sorted = lists:sort(Arr),
    case Sorted of
        [A, B | Rest] ->
            D = B - A,
            check_progression(Rest, B, D);
        _ ->
            true
    end.

check_progression([], _Prev, _D) -> true;
check_progression([H | T], Prev, D) ->
    case H - Prev of
        D -> check_progression(T, H, D);
        _ -> false
    end.