-module(solution).
-export([kth_nearest_queries/4]).

kth_nearest_queries(Obstacles, Queries, K, M) ->
    lists:map(fun({X, Y}) -> 
        Distances = lists:map(fun({Ox, Oy}) -> 
            abs(X - Ox) + abs(Y - Oy)
        end, Obstacles),
        Sorted = lists:sort(Distances),
        lists:nth(K, Sorted)
    end, Queries).