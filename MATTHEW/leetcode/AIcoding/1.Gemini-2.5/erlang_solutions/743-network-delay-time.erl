-module(solution).
-export([networkDelayTime/3]).

dijkstra(Graph, N, StartNode) ->
    Infinity = 1000000000,

    InitialDistances = maps:from_list([{I, Infinity} || I <- lists:seq(1, N)]),
    Distances0 = maps:put(StartNode, 0, InitialDistances),

    PQ0 = gb_trees:insert(0, StartNode, gb_trees:empty()),

    dijkstra_loop(PQ0, Distances0, Graph, N, Infinity).

dijkstra_loop(PQ, Distances, Graph, N, Infinity) ->
    case gb_trees:is_empty(PQ) of
        true ->
            MaxTime = maps:fold(fun(_Node, Time, Acc) ->
                                    case Time of
                                        Infinity -> Infinity;
                                        _ -> max(Time, Acc)
                                    end
                                end, 0, Distances),
            case MaxTime of
                Infinity -> -1;
                _ -> MaxTime
            end;
        false ->
            {{CurrentTime, CurrentNode}, PQ1} = gb_trees:take_smallest(PQ),

            case CurrentTime > maps:get(CurrentNode, Distances) of
                true ->
                    dijkstra_loop(PQ1, Distances, Graph, N, Infinity);
                false ->
                    Neighbors = maps:get(CurrentNode, Graph, []),
                    {NewPQ, NewDistances} = lists:foldl(
                        fun({NeighborNode, Weight}, {AccPQ, AccDistances}) ->
                            NewTime = CurrentTime + Weight,
                            case NewTime < maps:get(NeighborNode, AccDistances) of
                                true ->
                                    {gb_trees:insert(NewTime, NeighborNode, AccPQ),
                                     maps:put(NeighborNode, NewTime, AccDistances)};
                                false ->
                                    {AccPQ, AccDistances}
                            end
                        end, {PQ1, Distances}, Neighbors),
                    dijkstra_loop(NewPQ, NewDistances, Graph, N, Infinity)
            end
    end.

networkDelayTime(Times, N, K) ->
    Graph = lists:foldl(
        fun([U, V, W], AccGraph) ->
            maps:update_with(U, fun(List) -> [{V, W} | List] end, [{V, W}], AccGraph)
        end, maps:new(), Times),

    dijkstra(Graph, N, K).