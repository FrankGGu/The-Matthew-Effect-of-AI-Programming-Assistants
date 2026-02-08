-module(small_range_ii).
-export([new/0, solve/1]).

solve(Nums) ->
    N = length(Nums),
    if
        N == 0 -> 0;
        true ->
            Sorted = lists:sort(Nums),
            Min = lists:nth(1, Sorted),
            Max = lists:last(Sorted),
            Result = lists:foldl(fun(X, Acc) ->
                lists:min([Acc, (Max - X), (X - Min)]) end, Max - Min, Sorted)
    end.

new() ->
    ok.