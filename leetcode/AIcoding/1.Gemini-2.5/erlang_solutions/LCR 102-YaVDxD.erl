-module(solution).
-export([find_target_sum_ways/2]).

find_target_sum_ways(Nums, S) ->
    TotalSum = lists:sum(Nums),

    IfCondition = (TotalSum + S < 0) orelse ((TotalSum + S) rem 2 /= 0),
    if IfCondition ->
        0;
    true ->
        TargetP = (TotalSum + S) div 2,

        DP0 = #{0 => 1},

        FinalDP = lists:foldl(
            fun(Num, AccDP) ->
                lists:foldl(
                    fun(CurrentSum, InnerAccDP) ->
                        CountWithoutNum = maps:get(CurrentSum, InnerAccDP, 0),
                        CountWithNum = maps:get(CurrentSum - Num, InnerAccDP, 0),

                        maps:put(CurrentSum, CountWithoutNum + CountWithNum, InnerAccDP)
                    end,
                    AccDP,
                    lists:seq(TargetP, Num, -1)
                )
            end,
            DP0,
            Nums
        ),

        maps:get(TargetP, FinalDP, 0)
    end
).