-module(solution).
-export([num_ways/2]).

num_ways(N, K) ->
    Max = 1000000007,
    DP = array:new([{size, N}, {default, 0}]),
    DP1 = array:set(0, 1, DP),
    lists:foldl(fun(_, Acc) ->
        DP2 = array:new([{size, N}, {default, 0}]),
        lists:foreach(fun(I) ->
            Val = array:get(I, Acc),
            if
                I > 0 -> array:set(I, (array:get(I, DP2) + Val) rem Max, DP2);
                true -> DP2
            end,
            if
                I < N-1 -> array:set(I+1, (array:get(I+1, DP2) + Val) rem Max, DP2);
                true -> DP2
            end
        end, lists:seq(0, N-1)),
        DP2
    end, DP1, lists:seq(1, K)),

    array:get(0, DP).

-module(solution).
-export([num_ways/2]).

num_ways(N, K) ->
    Max = 1000000007,
    DP = array:new([{size, N}, {default, 0}]),
    DP1 = array:set(0, 1, DP),
    lists:foldl(fun(_, Acc) ->
        DP2 = array:new([{size, N}, {default, 0}]),
        lists:foreach(fun(I) ->
            Val = array:get(I, Acc),
            array:set(I, (array:get(I, DP2) + Val) rem Max, DP2),
            if
                I > 0 -> array:set(I-1, (array:get(I-1, DP2) + Val) rem Max, DP2);
                true -> DP2
            end,
            if
                I < N-1 -> array:set(I+1, (array:get(I+1, DP2) + Val) rem Max, DP2);
                true -> DP2
            end
        end, lists:seq(0, N-1)),
        DP2
    end, DP1, lists:seq(1, K)),

    array:get(0, DP).