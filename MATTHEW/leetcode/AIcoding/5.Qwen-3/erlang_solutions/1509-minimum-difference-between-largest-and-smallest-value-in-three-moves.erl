-module(minimum_difference).
-export([leastDifference/1]).

leastDifference(Nums) ->
    N = length(Nums),
    if
        N =< 4 -> 0;
        true ->
            Sorted = lists:sort(Nums),
            lists:min([
                lists:nth(N - 3, Sorted) - lists:nth(0, Sorted),
                lists:nth(N - 2, Sorted) - lists:nth(1, Sorted),
                lists:nth(N - 1, Sorted) - lists:nth(2, Sorted),
                lists:nth(N, Sorted) - lists:nth(3, Sorted)
            ])
    end.