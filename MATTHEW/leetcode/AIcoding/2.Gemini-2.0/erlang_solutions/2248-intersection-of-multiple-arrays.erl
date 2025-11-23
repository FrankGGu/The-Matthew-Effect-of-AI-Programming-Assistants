-module(intersection_multiple_arrays).
-export([intersection/1]).

intersection(Nums) ->
    case Nums of
        [] -> [];
        [First | Rest] ->
            lists:foldl(fun(Arr, Acc) -> intersect(Arr, Acc) end, First, Rest)
    end.

intersect(Arr1, Arr2) ->
    lists:filter(fun(X) -> lists:member(X, Arr2) end, Arr1).