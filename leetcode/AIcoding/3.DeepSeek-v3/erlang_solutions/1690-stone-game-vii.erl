-spec stone_game_vii(Stones :: [integer()]) -> integer().
stone_game_vii(Stones) ->
    N = length(Stones),
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Stones),
    PrefixSum = lists:reverse(Prefix),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    {Result, _} = solve(1, N, PrefixSum, DP),
    Result.

solve(I, J, PrefixSum, DP) ->
    case I >= J of
        true -> {0, DP};
        false ->
            case array:get(I, array:get(J, DP)) of
                0 ->
                    Sum = lists:nth(J, PrefixSum) - lists:nth(I, PrefixSum),
                    {Left, DP1} = solve(I + 1, J, PrefixSum, DP),
                    {Right, DP2} = solve(I, J - 1, PrefixSum, DP1),
                    Val = max(Sum - Left, Sum - Right),
                    NewRow = array:set(J, Val, array:get(I, DP2)),
                    NewDP = array:set(I, NewRow, DP2),
                    {Val, NewDP};
                Val -> {Val, DP}
            end
    end.