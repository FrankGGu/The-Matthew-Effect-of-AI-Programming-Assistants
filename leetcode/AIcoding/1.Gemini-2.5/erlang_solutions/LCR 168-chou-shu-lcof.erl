-spec is_ugly(N :: integer()) -> boolean().
is_ugly(N) when N =< 0 -> false;
is_ugly(1) -> true;
is_ugly(N) ->
    N2 = divide_by_factor(N, 2),
    N3 = divide_by_factor(N2, 3),
    N5 = divide_by_factor(N3, 5),
    N5 == 1.

divide_by_factor(N, Factor) when N rem Factor == 0 ->
    divide_by_factor(N div Factor, Factor);
divide_by_factor(N, _Factor) ->
    N.