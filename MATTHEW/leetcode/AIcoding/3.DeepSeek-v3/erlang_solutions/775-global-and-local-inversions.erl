-spec is_ideal_permutation(Nums :: [integer()]) -> boolean().
is_ideal_permutation(Nums) ->
    N = length(Nums),
    Max = -1,
    check_global(Nums, 0, N, Max).

check_global([], _I, _N, _Max) -> true;
check_global([X | T], I, N, Max) ->
    if
        X < Max -> false;
        true ->
            NewMax = if
                X > Max -> X;
                true -> Max
            end,
            check_global(T, I + 1, N, NewMax)
    end.