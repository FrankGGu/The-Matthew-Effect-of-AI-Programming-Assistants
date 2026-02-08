-module(solution).
-export([find_the_city/3]).

find_the_city(N, Edges, DistanceThreshold) ->
    Dist = initialize_dist(N, Edges),
    FloydWarshall(N, Dist),
    {MinCity, _} = find_min_city(N, Dist, DistanceThreshold),
    MinCity.

initialize_dist(N, Edges) ->
    Dist = array:new([{size, N}, {default, array:new([{size, N}, {default, 10001}])}]),
    lists:foldl(fun({From, To, W}, Acc) ->
                    array:set(From, array:set(To, W, array:get(From, Acc)), Acc),
                    array:set(To, array:set(From, W, array:get(To, Acc)), Acc)
                end, Dist, Edges).

FloydWarshall(N, Dist) ->
    lists:foreach(fun(K) ->
        lists:foreach(fun(I) ->
            lists:foreach(fun(J) ->
                Dik = array:get(I, array:get(K, Dist)),
                Dkj = array:get(K, array:get(J, Dist)),
                Dij = array:get(I, array:get(J, Dist)),
                if Dik + Dkj < Dij ->
                    NewDist = array:set(J, Dik + Dkj, array:get(I, Dist)),
                    array:set(I, NewDist, Dist);
                true -> ok
                end
            end, lists:seq(0, N-1))
        end, lists:seq(0, N-1))
    end, lists:seq(0, N-1)).

find_min_city(N, Dist, Threshold) ->
    Counts = lists:map(fun(I) ->
        Count = lists:foldl(fun(J, Acc) ->
            D = array:get(I, array:get(J, Dist)),
            if I =/= J, D =< Threshold -> Acc + 1;
               true -> Acc
            end
        end, 0, lists:seq(0, N-1)),
        {Count, I}
    end, lists:seq(0, N-1)),
    lists:min(Counts).