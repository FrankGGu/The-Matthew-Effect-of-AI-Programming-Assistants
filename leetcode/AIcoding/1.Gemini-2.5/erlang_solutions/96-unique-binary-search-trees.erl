-module(solution).
-export([numTrees/1]).

numTrees(N) ->
    DP = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),
    DP1 = array:set(0, 1, DP),
    InitialDP = array:set(1, 1, DP1),

    ResultDP = lists:foldl(
        fun(I, CurrentDP) ->
            Sum = lists:foldl(
                fun(J, Acc) ->
                    Acc + (array:get(J - 1, CurrentDP) * array:get(I - J, CurrentDP))
                end,
                0,
                lists:seq(1, I)
            ),
            array:set(I, Sum, CurrentDP)
        end,
        InitialDP,
        lists:seq(2, N)
    ),
    array:get(N, ResultDP).