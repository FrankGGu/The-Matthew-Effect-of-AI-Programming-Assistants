-module(minimum_sum_of_squared_difference).
-export([minSumSquareDifference/2]).

minSumSquareDifference(Price, MaxChange) ->
    lists:foldl(fun({P, C}, Acc) -> 
        {P + C, Acc} end, 0, lists:zip(Price, MaxChange)).

minSumSquareDifference(_, _) ->
    0.