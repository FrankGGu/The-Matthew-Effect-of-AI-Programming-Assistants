-module(minimum_absolute_difference).
-export([minimumAbsoluteDifference/2]).

minimumAbsoluteDifference(Nums, queries) ->
    Sorted = lists:sort(Nums),
    lists:map(fun(Query) -> findMinDiff(Sorted, Query) end, queries).

findMinDiff(Sorted, {L, R}) ->
    lists:foldl(fun(I, Acc) ->
        if I+1 =< R -> 
            Diff = abs(lists:nth(I+1, Sorted) - lists:nth(I, Sorted)),
            if Diff < Acc -> Diff; true -> Acc end;
        true -> Acc
    end end, infinity, lists:seq(L-1, R-2)).