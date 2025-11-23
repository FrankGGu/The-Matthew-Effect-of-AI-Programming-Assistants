-module(kth_nearest_obstacle_queries).
-export([kth_nearby_obstacles/2]).

kth_nearby_obstacles(Points, Queries) ->
    kth_nearby_obstacles(Points, Queries, 1, []).

kth_nearby_obstacles([], _, _, Acc) ->
    lists:reverse(Acc);
kth_nearby_obstacles([Point | Points], Queries, K, Acc) ->
    Sorted = lists:sort([{distance(Point, Q), Q} || Q <- Queries]),
    case lists:nth(K, Sorted) of
        {D, Q} -> kth_nearby_obstacles(Points, Queries, K + 1, [Q | Acc]);
        _ -> kth_nearby_obstacles(Points, Queries, K + 1, [0 | Acc])
    end.

distance({X1, Y1}, {X2, Y2}) ->
    math:sqrt(math:pow(X1 - X2, 2) + math:pow(Y1 - Y2, 2)).