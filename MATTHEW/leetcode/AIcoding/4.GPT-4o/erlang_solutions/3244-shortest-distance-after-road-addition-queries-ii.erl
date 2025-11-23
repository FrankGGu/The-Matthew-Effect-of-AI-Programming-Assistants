-module(solution).
-export([shortest_distance/3]).

shortest_distance(N, roads, queries) ->
    Graph = build_graph(N, roads),
    lists:map(fun({from, to}) -> dijkstra(Graph, from, to) end, queries).

build_graph(N, Roads) ->
    Graph = lists:foldl(fun({u, v, w}, Acc) ->
        add_edge(Acc, u, v, w),
        add_edge(Acc, v, u, w)
    end, lists:seq(1, N), Roads),
    Graph.

add_edge(Graph, U, V, W) ->
    case lists:keyfind(U, 1, Graph) of
        false -> [{U, [{V, W}]} | Graph];
        {U, Edges} -> [{U, [{V, W} | Edges]} | lists:keydelete(U, 1, Graph)]
    end.

dijkstra(Graph, From, To) ->
    Distances = lists:foldl(fun({Node, _}, Acc) -> maps:put(Node, infinity, Acc) end, #{}, Graph),
    Distances1 = maps:put(From, 0, Distances),
    dijkstra_loop([{0, From}], Distances1, To).

dijkstra_loop([], Distances, To) ->
    case maps:get(To, Distances) of
        infinity -> -1;
        Distance -> Distance
    end;

dijkstra_loop([{Dist, Node} | Rest], Distances, To) ->
    NewDistances = lists:foldl(fun({Neighbor, Weight}, Acc) ->
        NewDist = Dist + Weight,
        case maps:get(Neighbor, Acc) of
            CurrentDist when NewDist < CurrentDist -> maps:put(Neighbor, NewDist, Acc);
            _ -> Acc
        end
    end, Distances, get_neighbors(Node, Graph)),
    dijkstra_loop(Rest ++ lists:filter(fun({_, Neighbor}) -> maps:get(Neighbor, NewDistances) < infinity end, NewDistances), NewDistances, To).

get_neighbors(Node, Graph) ->
    case lists:keyfind(Node, 1, Graph) of
        false -> [];
        {Node, Edges} -> Edges
    end.