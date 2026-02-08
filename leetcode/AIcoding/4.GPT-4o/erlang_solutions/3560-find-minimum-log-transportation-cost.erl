-module(solution).
-export([min_transport_cost/3]).

min_transport_cost(N, roads, start) ->
    Graph = create_graph(N, roads),
    Dists = dijkstra(Graph, start, N),
    lists:min(Dists).

create_graph(N, Roads) ->
    lists:foldl(fun({A, B, C}, Acc) ->
        maps:update_with(A, fun(L) -> [ {B, C} | L ] end, [ {B, C} ], Acc)
    end, maps:new(), Roads).

dijkstra(Graph, Start, N) ->
    Dists = lists:duplicate(N, infinity),
    Dists1 = lists:update_element(Start + 1, 0, Dists),
    dijkstra_loop([{0, Start}], Dists1, Graph, lists:duplicate(N, false)).

dijkstra_loop([], Dists, _, _) -> Dists;
dijkstra_loop([{Dist, Node} | Rest], Dists, Graph, Visited) ->
    if 
        Visited[Node] ->
            dijkstra_loop(Rest, Dists, Graph, Visited);
        true ->
            Visited1 = lists:replace_element(Node, true, Visited),
            Neighbors = maps:get(Node, Graph, []),
            Dists2 = lists:foldl(fun({Neighbor, Cost}, Acc) ->
                NewDist = Dist + Cost,
                if 
                    NewDist < Acc[Neighbor] ->
                        lists:update_element(Neighbor, NewDist, Acc);
                    true -> Acc
                end
            end, Dists, Neighbors),
            dijkstra_loop(Rest ++ [{Dists2[Neighbor], Neighbor} || {Neighbor, _} <- Neighbors], Dists2, Graph, Visited1)
    end.