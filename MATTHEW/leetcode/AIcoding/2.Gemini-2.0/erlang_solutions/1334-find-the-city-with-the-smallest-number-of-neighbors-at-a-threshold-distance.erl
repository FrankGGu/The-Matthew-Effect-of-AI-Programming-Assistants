-module(find_the_city).
-export([find_the_city/3]).

find_the_city(N, Edges, DistanceThreshold) ->
    Adj = create_adjacency_matrix(N, Edges),
    Dist = floyd_warshall(N, Adj),
    find_smallest_city(N, Dist, DistanceThreshold).

create_adjacency_matrix(N, Edges) ->
    create_adjacency_matrix_helper(N, Edges, array:new(N, {fixed, N, {}})).

create_adjacency_matrix_helper(N, [], Acc) ->
    array:map(fun(Row) ->
                      array:map(fun({value, V}) ->
                                        case V of
                                            {} -> infinity;
                                            _ -> V
                                        end
                                 end, Row)
              end, Acc);
create_adjacency_matrix_helper(N, [{From, To, Weight} | Rest], Acc) ->
    NewAcc1 = array:set(From, array:set(To, Weight, array:get(From, Acc)), Acc),
    NewAcc2 = array:set(To, array:set(From, Weight, array:get(To, NewAcc1)), NewAcc1),
    create_adjacency_matrix_helper(N, Rest, NewAcc2).

floyd_warshall(N, Adj) ->
    Dist = initialize_distance_matrix(N, Adj),
    floyd_warshall_helper(N, Dist, 0).

floyd_warshall_helper(N, Dist, K) when K >= N ->
    Dist;
floyd_warshall_helper(N, Dist, K) ->
    NewDist = update_distance_matrix(N, Dist, K),
    floyd_warshall_helper(N, NewDist, K + 1).

initialize_distance_matrix(N, Adj) ->
    initialize_distance_matrix_helper(N, Adj, array:new(N, {fixed, N, {}}), 0, 0).

initialize_distance_matrix_helper(N, Adj, Acc, I, J) when I >= N ->
    array:map(fun(Row) ->
                      array:map(fun({value, V}) ->
                                        case V of
                                            {} -> infinity;
                                            _ -> V
                                        end
                                 end, Row)
              end, Acc);
initialize_distance_matrix_helper(N, Adj, Acc, I, J) when J >= N ->
    initialize_distance_matrix_helper(N, Adj, Acc, I + 1, 0);
initialize_distance_matrix_helper(N, Adj, Acc, I, J) ->
    Weight = array:get(I, array:get(J, Adj)),
    NewAcc = array:set(I, array:set(J, Weight, array:get(I, Acc)), Acc),
    initialize_distance_matrix_helper(N, Adj, NewAcc, I, J + 1).

update_distance_matrix(N, Dist, K) ->
    update_distance_matrix_helper(N, Dist, K, 0, 0).

update_distance_matrix_helper(N, Dist, K, I, J) when I >= N ->
    Dist;
update_distance_matrix_helper(N, Dist, K, I, J) when J >= N ->
    update_distance_matrix_helper(N, Dist, K, I + 1, 0);
update_distance_matrix_helper(N, Dist, K, I, J) ->
    DistIK = array:get(I, array:get(K, Dist)),
    DistKJ = array:get(K, array:get(J, Dist)),
    DistIJ = array:get(I, array:get(J, Dist)),
    NewDistIJ = min(DistIJ, DistIK + DistKJ),
    NewDist = array:set(I, array:set(J, NewDistIJ, array:get(I, Dist)), Dist),
    update_distance_matrix_helper(N, NewDist, K, I, J + 1).

find_smallest_city(N, Dist, DistanceThreshold) ->
    find_smallest_city_helper(N, Dist, DistanceThreshold, 0, -1, N + 1).

find_smallest_city_helper(N, Dist, DistanceThreshold, City, Result, MinReachable) when City >= N ->
    Result;
find_smallest_city_helper(N, Dist, DistanceThreshold, City, Result, MinReachable) ->
    Reachable = count_reachable(N, Dist, DistanceThreshold, City, 0, 0),
    if
        Reachable <= MinReachable ->
            find_smallest_city_helper(N, Dist, DistanceThreshold, City + 1, City, Reachable);
        true ->
            find_smallest_city_helper(N, Dist, DistanceThreshold, City + 1, Result, MinReachable)
    end.

count_reachable(N, Dist, DistanceThreshold, City, Neighbor, Count) when Neighbor >= N ->
    Count;
count_reachable(N, Dist, DistanceThreshold, City, Neighbor, Count) ->
    Distance = array:get(City, array:get(Neighbor, Dist)),
    NewCount = case Distance =< DistanceThreshold of
                   true -> Count + 1;
                   false -> Count
               end,
    count_reachable(N, Dist, DistanceThreshold, City, Neighbor + 1, NewCount).

min(A, B) when A < B -> A;
min(A, B) -> B.

infinity -> 16#7fffffff.