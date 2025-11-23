-spec stone_game_viii(Stones :: [integer()]) -> integer().
stone_game_viii(Stones) ->
    N = length(Stones),
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(Stones)),
    PrefixSum = lists:reverse(Prefix),
    DP = lists:duplicate(N, 0),
    DP1 = setelement(N, DP, lists:nth(N, PrefixSum)),
    DP2 = lists:foldl(fun(I, Acc) ->
        Current = max(lists:nth(I + 1, Acc), lists:nth(I + 1, PrefixSum) - lists:nth(I + 1, Acc)),
        setelement(I, Acc, Current)
    end, DP1, lists:seq(N - 1, 2, -1)),
    lists:nth(2, DP2).