-module(solution).
-export([number_of_ways/1]).

number_of_ways(K) ->
    case K of
        0 -> 1;
        1 -> 1;
        2 -> 2;
        _ -> 
            DP = array:new([{size, K + 1}, {default, 0}]),
            DP1 = array:set(0, 1, DP),
            DP2 = array:set(1, 1, DP1),
            DP3 = array:set(2, 2, DP2),
            number_of_ways_helper(3, K, DP3)
    end.

number_of_ways_helper(I, K, DP) ->
    if
        I > K -> array:get(K, DP);
        true ->
            Prev1 = array:get(I - 1, DP),
            Prev2 = array:get(I - 2, DP),
            Current = Prev1 + Prev2,
            NewDP = array:set(I, Current, DP),
            number_of_ways_helper(I + 1, K, NewDP)
    end.