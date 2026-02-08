-module(solution).
-export([shortest_distances/2]).

shortest_distances(NumRoads, Queries) ->
    Adj = lists:seq(0, NumRoads),
    Dist = array:new([{size, NumRoads + 1}, {default, infinity}]),
    Dist1 = array:set(0, 0, Dist),
    shortest_distances(Queries, Adj, Dist1).

shortest_distances([], _, Dist) ->
    array:to_list(Dist);

shortest_distances([Q | Rest], Adj, Dist) ->
    [A, B] = string:split(Q, " "),
    AInt = list_to_integer(A),
    BInt = list_to_integer(B),
    Adj1 = lists:umerge(Adj, [BInt, AInt]),
    Dist1 = dijkstra(Adj1, Dist),
    shortest_distances(Rest, Adj1, Dist1).

dijkstra(Adj, Dist) ->
    dijkstra(Adj, Dist, array:to_list(Dist), 0).

dijkstra(_, Dist, _, _) ->
    Dist;

dijkstra(Adj, Dist, Visited, Current) ->
    case lists:nth(Current + 1, Visited) of
        true ->
            dijkstra(Adj, Dist, Visited, Current + 1);
        false ->
            NewVisited = lists:substitute(Current + 1, true, Visited),
            Neighbors = lists:filter(fun(X) -> X /= Current end, lists:flatten(lists:map(fun(X) -> lists:member(X, Adj) end, [Current]))),
            Dist1 = update_neighbors(Neighbors, Current, Dist, Adj),
            dijkstra(Adj, Dist1, NewVisited, Current + 1)
    end.

update_neighbors([], _, Dist, _) ->
    Dist;

update_neighbors([N | Rest], Current, Dist, Adj) ->
    CurrentDist = array:get(Current, Dist),
    NDist = array:get(N, Dist),
    if
        CurrentDist + 1 < NDist ->
            Dist1 = array:set(N, CurrentDist + 1, Dist),
            update_neighbors(Rest, Current, Dist1, Adj);
        true ->
            update_neighbors(Rest, Current, Dist, Adj)
    end.