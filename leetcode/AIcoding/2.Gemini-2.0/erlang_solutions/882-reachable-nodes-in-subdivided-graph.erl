-module(reachable_nodes).
-export([reachableNodes/3]).

reachableNodes(Edges, MaxMoves, N) ->
    Graph = build_graph(Edges),
    dijkstra(0, Graph, MaxMoves, N).

build_graph(Edges) ->
    lists:foldl(fun([U, V, W], Acc) ->
                      Acc#{ {U, V} => W, {V, U} => W }
                  end, #{}, Edges).

dijkstra(Start, Graph, MaxMoves, N) ->
    {Reachable, UsedEdges} = dijkstra_helper(Start, Graph, MaxMoves, #{}, #{}, [Start]),
    ReachableCount = maps:size(Reachable),
    EdgeCount = maps:fold(fun(_Key, Value, Acc) -> Acc + Value end, 0, UsedEdges),
    min(ReachableCount + EdgeCount, N).

dijkstra_helper(Node, Graph, Moves, Reachable, UsedEdges, Queue) ->
    case Queue of
        [] ->
            {Reachable, UsedEdges};
        [H | T] ->
            case maps:get(H, Reachable, -1) of
                Dist when Dist >= Moves ->
                    dijkstra_helper(Node, Graph, Moves, Reachable, UsedEdges, T);
                _ ->
                    NewReachable = Reachable#{H => Moves},
                    Neighbors = get_neighbors(H, Graph),
                    NewQueue = T ++ lists:map(fun({Neighbor, Weight}) -> Neighbor end, Neighbors),
                    {NewReachable2, NewUsedEdges2} = lists:foldl(
                        fun({Neighbor, Weight}, {AccReachable, AccUsedEdges}) ->
                            NewMoves = Moves - (Weight + 1),
                            if NewMoves >= 0 then
                                NewAccUsedEdges = maps:update({min(H, Neighbor), max(H, Neighbor)}, fun(Value) -> Value + Weight end, AccUsedEdges#{ {min(H, Neighbor), max(H, Neighbor)} => Weight }),
                                {AccReachable, NewAccUsedEdges}
                            else
                                {AccReachable, AccUsedEdges}
                            end
                        end,
                        {NewReachable, UsedEdges},
                        Neighbors
                    ),

                    NewNeighbors = lists:filter(fun({Neighbor, Weight}) -> Moves - (Weight + 1) > maps:get(Neighbor, Reachable, -1) end, Neighbors),

                    dijkstra_helper(Node, Graph, Moves, NewReachable2, NewUsedEdges2, NewQueue)
            end
    end.

get_neighbors(Node, Graph) ->
    lists:foldl(
        fun({Key, Value}, Acc) ->
            case Key of
                {Node, Neighbor} ->
                    [ {Neighbor, Value} | Acc ];
                {Neighbor, Node} ->
                    [ {Neighbor, Value} | Acc ];
                _ ->
                    Acc
            end
        end,
        [],
        maps:to_list(Graph)
    ).