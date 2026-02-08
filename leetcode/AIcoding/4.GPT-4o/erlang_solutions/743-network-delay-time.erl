-module(solution).
-export([network_delay_time/3]).

network_delay_time(N, edges, K) ->
    Graph = maps:fold(fun({X, Y, W}, Acc) -> 
                         maps:update_with(X, fun(L) -> [{Y, W} | L] end, [{Y, W}], Acc)
                     end, maps:new(), edges),
    Distances = dijkstra(Graph, K, N),
    case maps:get(N, Distances, infinity) of
        infinity -> -1;
        Time -> Time
    end.

dijkstra(Graph, Start, N) ->
    Queue = [{0, Start}],
    dijkstra_helper(Graph, Queue, maps:new(), N).

dijkstra_helper(_, [], Distances, _) -> Distances;
dijkstra_helper(Graph, [{Cost, Node} | Rest], Distances, N) ->
    Distances1 = case maps:is_key(Node, Distances) of
        true -> Distances;
        false -> maps:put(Node, Cost, Distances)
    end,
    Neighbors = maps:get(Node, Graph, []),
    NewQueue = lists:foldl(fun({Neighbor, Weight}, Acc) ->
                                NewCost = Cost + Weight,
                                case maps:get(Neighbor, Distances1, infinity) of
                                    OldCost when NewCost < OldCost -> [{NewCost, Neighbor} | Acc];
                                    _ -> Acc
                                end
                            end, Rest, Neighbors),
    dijkstra_helper(Graph, lists:sort(NewQueue), Distances1, N).