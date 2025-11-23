-module(solution).
-export([combinationSum4/2]).

combinationSum4(Nums, Target) ->
    DP0 = #{0 => 1},

    FinalDP = lists:foldl(
        fun(I, CurrentDP) ->
            ValueForI = lists:foldl(
                fun(Num, Sum) ->
                    PrevI = I - Num,
                    case PrevI >= 0 of
                        true ->
                            Sum + maps:get(PrevI, CurrentDP, 0);
                        false ->
                            Sum
                    end
                end,
                0,
                Nums
            ),
            maps:put(I, ValueForI, CurrentDP)
        end,
        DP0,
        lists:seq(1, Target)
    ),

    maps:get(Target, FinalDP, 0).