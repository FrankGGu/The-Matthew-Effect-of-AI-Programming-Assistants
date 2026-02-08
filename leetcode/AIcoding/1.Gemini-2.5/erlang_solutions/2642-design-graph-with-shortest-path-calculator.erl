-module(solution).
-export([init/2, addEdge/2, shortestPath/3]).

init(_N, Edges) ->
    lists:foldl(fun(Edge, Graph) -> addEdge(Graph, Edge) end, #{}, Edges).

addEdge(Graph, [U, V, W]) ->
    maps:update_with(U, fun(Adj) -> maps:put(V, W, Adj) end, #{V => W}, Graph).

shortestPath(Graph, Node1, Node2) ->
    Infinity = 1_000_000_000_000,
    Distances = maps:put(Node1, 0, #{}),
    PQ = gb_trees:insert({0, Node1}, gb_trees:empty()),
    Result = dijkstra(PQ, Distances, Graph, Node2, Infinity),
    case Result == Infinity of
        true -> -1;
        false -> Result
    end.

dijkstra(PQ, Distances, Graph, TargetNode, Infinity) ->
    case gb_trees:is_empty(PQ) of
        true ->
            maps:get(TargetNode, Distances, Infinity);
        false ->
            {{Cost, CurrentNode}, _, PQ1} = gb_trees:take_smallest(PQ),
            case Cost > maps:get(CurrentNode, Distances, Infinity) of
                true ->
                    dijkstra(PQ1, Distances, Graph, TargetNode, Infinity);
                false ->
                    case CurrentNode == TargetNode of
                        true ->
                            Cost;
                        false ->
                            Neighbors = maps:get(CurrentNode, Graph, #{}),
                            {NewDistances, NewPQ} = maps:fold(
                                fun(Neighbor, Weight, {AccDistances, AccPQ}) ->
                                    NewCost = Cost + Weight,
                                    OldNeighborCost = maps:get(Neighbor, AccDistances, Infinity),
                                    case NewCost < OldNeighborCost of
                                        true ->
                                            {maps:put(Neighbor, NewCost, AccDistances),
                                             gb_trees:insert({NewCost, Neighbor}, AccPQ)};
                                        false ->
                                            {AccDistances, AccPQ}
                                    end
                                end,
                                {Distances, PQ1},
                                Neighbors
                            ),
                            dijkstra(NewPQ, NewDistances, Graph, TargetNode, Infinity)
                    end
            end
    end.