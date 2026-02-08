-module(solution).
-export([find_the_city/3]).

find_the_city(N, edges, distanceThreshold) ->
    Paths = init_paths(N, edges),
    lists:foldl(fun(City, Acc) -> min_city(City, Acc, Paths, distanceThreshold) end, {infinity, -1}, lists:seq(0, N - 1)).

init_paths(N, Edges) ->
    Distances = lists:duplicate(N, lists:duplicate(N, infinity)),
    Edges1 = lists:map(fun({A, B, D}) -> 
        Distances1 = lists:update_element(B + 1, D, lists:update_element(A + 1, D, Distances)),
        lists:update_element(A + 1, D, lists:update_element(B + 1, D, Distances1))
    end, Edges),
    lists:foldl(fun(_, Acc) -> floyd_warshall(Acc) end, Distances1, lists:seq(1, N - 1)).

floyd_warshall(Distances) ->
    lists:foldl(fun(K, Acc) -> 
        lists:foldl(fun(I, Acc1) -> 
            lists:foldl(fun(J, Acc2) -> 
                if Acc1[I][J] > Acc1[I][K] + Acc1[K][J] -> 
                    lists:update_element(J + 1, Acc1[I][K] + Acc1[K][J], Acc2)
                end
            end, Acc2, lists:seq(0, length(Acc1) - 1))
        end, Acc1, lists:seq(0, length(Acc1) - 1))
    end, Distances, lists:seq(0, length(Distances) - 1)).

min_city(City, {MinCount, MinCity}, Paths, distanceThreshold) ->
    NeighborsCount = count_neighbors(City, Paths, distanceThreshold),
    if NeighborsCount < MinCount -> 
        {NeighborsCount, City}
    ; NeighborsCount =:= MinCount -> 
        {MinCount, min(City, MinCity)}
    ; 
        {MinCount, MinCity}
    end.

count_neighbors(City, Paths, distanceThreshold) ->
    lists:foldl(fun(Distance, Acc) -> 
        if Distance =< distanceThreshold -> 
            Acc + 1 
        ; 
            Acc 
        end
    end, 0, Paths[City + 1]).