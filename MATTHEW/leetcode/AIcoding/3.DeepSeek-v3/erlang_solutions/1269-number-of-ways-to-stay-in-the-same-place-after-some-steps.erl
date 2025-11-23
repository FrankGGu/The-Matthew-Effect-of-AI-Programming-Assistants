-module(solution).
-export([num_ways/2]).

num_ways(Steps, ArrLen) ->
    MaxPos = min(Steps div 2 + 1, ArrLen),
    DP = array:new([{size, MaxPos}, {default, 0}]),
    DP1 = array:set(0, 1, DP),
    num_ways(Steps, MaxPos, DP1).

num_ways(0, _, DP) -> array:get(0, DP);
num_ways(Steps, MaxPos, DP) ->
    NewDP = array:new([{size, MaxPos}, {default, 0}]),
    F = fun(I, Acc) ->
            Ways = array:get(I, DP),
            if
                I > 0 -> array:set(I - 1, (array:get(I - 1, Acc) + Ways) rem 1000000007, Acc);
                true -> Acc
            end,
            if
                I < MaxPos - 1 -> array:set(I + 1, (array:get(I + 1, Acc) + Ways) rem 1000000007, Acc);
                true -> Acc
            end,
            array:set(I, (array:get(I, Acc) + Ways) rem 1000000007, Acc)
        end,
    UpdatedDP = lists:foldl(F, NewDP, lists:seq(0, MaxPos - 1)),
    num_ways(Steps - 1, MaxPos, UpdatedDP).