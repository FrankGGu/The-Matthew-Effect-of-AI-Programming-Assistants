-module(solution).
-export([kth_nearest_obstacle_queries/3]).

kth_nearest_obstacle_queries(M, O, Queries) ->
    ObstacleMap = maps:from_list(O),
    lists:map(fun({X, Y, K}) -> find_kth_nearest(X, Y, K, ObstacleMap) end, Queries).

find_kth_nearest(X, Y, K, ObstacleMap) ->
    Neighbors = [{X1, Y1} || X1 <- [X-1, X, X+1], Y1 <- [Y-1, Y, Y+1], {X1, Y1} /= {X, Y}],
    Distances = lists:sort([{manhattan_distance(X, Y, NX, NY), {NX, NY}} || {NX, NY} <- Neighbors, maps:is_key({NX, NY}, ObstacleMap)]),
    case lists:split(K, Distances) of
        {L, _} -> 
            case lists:nth(K, L) of
                {D, {NX, NY}} -> {NX, NY};
                _ -> {-1, -1}
            end
    end.

manhattan_distance(X1, Y1, X2, Y2) ->
    abs(X1 - X2) + abs(Y1 - Y2).