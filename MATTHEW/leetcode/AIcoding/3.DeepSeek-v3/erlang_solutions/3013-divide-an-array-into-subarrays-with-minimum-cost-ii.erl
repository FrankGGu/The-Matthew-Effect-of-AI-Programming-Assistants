-spec min_cost(nums :: [integer()], k :: integer()) -> integer().
min_cost(Nums, K) ->
    N = length(Nums),
    DP = array:new([{size, N + 1}, {default, infinity}]),
    DP1 = array:set(0, 0, DP),
    {DP2, _} = lists:foldl(fun(I, {DpAcc, _}) ->
        Freq = maps:new(),
        Cost = 0,
        {DpAcc1, _} = lists:foldl(fun(J, {DpInner, FreqInner}) ->
            Num = lists:nth(J, Nums),
            Freq1 = case maps:get(Num, FreqInner, undefined) of
                undefined -> maps:put(Num, 1, FreqInner);
                Count -> maps:put(Num, Count + 1, FreqInner)
            end,
            NewCount = maps:get(Num, Freq1),
            Cost1 = case NewCount of
                2 -> Cost + 2;
                C when C > 2 -> Cost + 1;
                _ -> Cost
            end,
            Current = array:get(I, DpInner),
            NewVal = case Current of
                infinity -> array:get(J - 1, DpInner) + Cost1 + K;
                _ -> min(Current, array:get(J - 1, DpInner) + Cost1 + K)
            end,
            {array:set(J, NewVal, DpInner), Freq1}
        end, {DpAcc, Freq}, lists:seq(I, min(I + 200, N))),
        {DpAcc1, I}
    end, {DP1, 1}, lists:seq(1, N)),
    array:get(N, DP2).