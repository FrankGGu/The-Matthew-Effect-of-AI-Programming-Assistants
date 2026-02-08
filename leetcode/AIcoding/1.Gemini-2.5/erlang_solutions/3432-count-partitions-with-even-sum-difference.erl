-module(solution).
-export([count_partitions/2]).

count_partitions(Nums, Diff) ->
    TotalSum = lists:sum(Nums),

    RequiredSum = TotalSum + Diff,

    if
        RequiredSum < 0 orelse (RequiredSum rem 2 =/= 0) ->
            0;
        true ->
            Target = RequiredSum div 2,

            DP0 = maps:put(0, 1, maps:new()),

            FinalDP = lists:foldl(
                fun(Num, CurrentDP) ->
                    lists:foldl(
                        fun(J, InnerDP) ->
                            PrevCount = maps:get(J - Num, CurrentDP, 0),
                            CurrentCount = maps:get(J, InnerDP, 0),
                            maps:put(J, CurrentCount + PrevCount, InnerDP)
                        end,
                        CurrentDP,
                        lists:seq(Target, Num, -1)
                    )
                end,
                DP0,
                Nums
            ),

            maps:get(Target, FinalDP, 0)
    end.