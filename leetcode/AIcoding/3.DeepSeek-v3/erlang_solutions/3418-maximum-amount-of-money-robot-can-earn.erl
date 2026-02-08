-spec maximum_money(coins :: [integer()]) -> integer().
maximum_money(Coins) ->
    N = length(Coins),
    DP = array:new([{size, N + 1}, {default, 0}]),
    DP1 = array:set(1, lists:nth(1, Coins), DP),
    DP2 = case N >= 2 of
        true -> array:set(2, max(lists:nth(1, Coins), lists:nth(2, Coins)), DP1);
        false -> DP1
    end,
    DP3 = lists:foldl(fun(I, Acc) ->
        Prev = array:get(I - 1, Acc),
        Curr = array:get(I - 2, Acc) + lists:nth(I, Coins),
        array:set(I, max(Prev, Curr), Acc)
    end, DP2, lists:seq(3, N)),
    array:get(N, DP3).