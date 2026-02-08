-module(solution).
-export([second_min_time/3]).

second_min_time(N, edges, time) ->
    Graph = build_graph(edges),
    Paths = dijkstra(Graph, 1, N, time),
    case Paths of
        [] -> -1;
        _ -> lists:nth(2, lists:sort(Paths))
    end.

build_graph(Edges) ->
    lists:foldl(fun({A, B, T}, Acc) ->
        maps:update_with(A, fun(L) -> [B | L] end, [B], Acc)
    end, #{}, Edges).

dijkstra(Graph, Start, N, Time) ->
    PriorityQueue = [{0, Start, 0}],
    Visited = maps:new(),
    dijkstra_helper(PriorityQueue, Visited, N, Time, []).

dijkstra_helper([], _, _, _, Paths) -> Paths;
dijkstra_helper([{Cost, Node, PathCount} | Rest], Visited, N, Time, Paths) ->
    if
        Node == N -> 
            dijkstra_helper(Rest, Visited, N, Time, [Cost | Paths]);
        maps:is_key(Node, Visited) -> 
            dijkstra_helper(Rest, Visited, N, Time, Paths);
        true ->
            NewVisited = maps:put(Node, PathCount, Visited),
            NextNodes = get_neighbors(Graph, Node),
            NewQueue = lists:foldl(fun({Neighbor, TravelTime}, Acc) ->
                NextCost = Cost + TravelTime,
                if
                    NextCost < Time -> [{NextCost, Neighbor, PathCount + 1} | Acc];
                    true -> Acc
                end
            end, Rest, NextNodes),
            dijkstra_helper(NewQueue, NewVisited, N, Time, Paths)
    end.

get_neighbors(Graph, Node) ->
    case maps:get(Node, Graph, []) of
        Neighbors -> lists:map(fun(Neighbor) -> {Neighbor, 1} end, Neighbors);
        [] -> []
    end.