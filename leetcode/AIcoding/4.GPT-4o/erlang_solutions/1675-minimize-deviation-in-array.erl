-module(solution).
-export([minimum_deviation/1]).

minimum_deviation(Nums) ->
    Sorted = lists:map(fun(X) -> if X rem 2 =:= 0 -> X; true -> X * 2 end end, Nums),
    Max = lists:max(Sorted),
    Min = lists:min(Sorted),
    minimum_deviation(Sorted, Max, Min).

minimum_deviation(Sorted, Max, Min) when Max rem 2 =:= 0 ->
    NewSorted = lists:map(fun(X) -> if X =:= Max -> X div 2; true -> X end end, Sorted),
    NewMax = lists:max(NewSorted),
    NewMin = lists:min(NewSorted),
    minimum_deviation(NewSorted, NewMax, NewMin);
minimum_deviation(_, Max, Min) ->
    Max - Min.