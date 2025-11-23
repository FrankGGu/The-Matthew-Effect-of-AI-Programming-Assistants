-spec ways_to_earn_points(Target :: integer(), Types :: [[integer()]]) -> integer().
ways_to_earn_points(Target, Types) ->
    Mod = 1000000007,
    DP = maps:put(0, 1, maps:new()),
    lists:foldl(
        fun([Count, Mark], Acc) ->
            maps:fold(
                fun(Sum, Ways, InnerAcc) ->
                    lists:foldl(
                        fun(K, InnerInnerAcc) ->
                            NewSum = Sum + K * Mark,
                            if
                                NewSum > Target -> InnerInnerAcc;
                                true ->
                                    NewWays = maps:get(NewSum, InnerInnerAcc, 0) + Ways,
                                    maps:put(NewSum, NewWays rem Mod, InnerInnerAcc)
                            end
                        end,
                        InnerAcc,
                        lists:seq(0, Count)
                end,
                Acc,
                DP)
        end,
        DP,
        Types),
    maps:get(Target, DP, 0).