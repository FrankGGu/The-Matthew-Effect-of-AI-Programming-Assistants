-module(solution).
-export([canPartition/1]).

canPartition(Nums) ->
    TotalSum = lists:sum(Nums),
    case TotalSum rem 2 of
        1 -> false;
        0 ->
            Target = TotalSum div 2,
            ReachableSums = gb_set:from_list([0]),
            FinalReachableSums = lists:foldl(
                fun(Num, AccReachableSums) ->
                    CurrentSums = gb_set:to_list(AccReachableSums),
                    lists:foldl(
                        fun(S, InnerAcc) ->
                            gb_set:add(S + Num, InnerAcc)
                        end,
                        AccReachableSums,
                        CurrentSums
                    )
                end,
                ReachableSums,
                Nums
            ),
            gb_set:is_member(Target, FinalReachableSums)
    end.