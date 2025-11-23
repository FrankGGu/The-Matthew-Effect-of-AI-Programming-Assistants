-module(dice_roll_simulation).
-export([numRollsToTarget/2]).

numRollsToTarget(Target, M) ->
    Mod = 1000000007,
    Max = 6 * M,
    if
        Target > Max -> 0;
        true ->
            DP = array:new(Max + 1, {0, 0}),
            DP1 = array:set(0, 1, DP),
            numRollsToTargetHelper(DP1, M, Target, Mod)
    end.

numRollsToTargetHelper(DP, 0, Target, _Mod) ->
    array:get(Target, DP);
numRollsToTargetHelper(DP, RollsLeft, Target, Mod) ->
    DP1 = array:new(array:size(DP), {0, 0}),
    lists:foreach(
        fun(Sum) ->
            lists:foreach(
                fun(Face) ->
                    NewSum = Sum + Face,
                    if
                        NewSum > array:size(DP) - 1 -> ok;
                        true ->
                            Count = array:get(Sum, DP),
                            NewCount = (array:get(NewSum, DP1) + Count) rem Mod,
                            DP2 = array:set(NewSum, NewCount, DP1),
                            DP1 = DP2
                    end
                end,
                lists:seq(1, 6)
            )
        end,
        lists:seq(0, array:size(DP) - 1)
    ),
    numRollsToTargetHelper(DP1, RollsLeft - 1, Target, Mod).