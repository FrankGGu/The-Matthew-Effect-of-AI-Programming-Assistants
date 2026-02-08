-module(minimum_time_to_visit_disappearing_nodes).
-export([minimumTime/2]).

minimumTime(N, Edges) ->
    Graph = buildGraph(Edges),
    {MinTime, _} = dijkstra(N, Graph, 0),
    MinTime.

buildGraph(Edges) ->
    lists:foldl(fun({U, V, W}, Acc) ->
        Acc1 = maps:put(U, [{V, W} | maps:get(U, Acc, [])], Acc),
        maps:put(V, [{U, W} | maps:get(V, Acc1, [])], Acc1)
    end, #{}, Edges).

dijkstra(N, Graph, Start) ->
    Dist = maps:from_list([{I, infinity} || I <- lists:seq(0, N-1)]),
    Dist1 = maps:put(Start, 0, Dist),
    PQ = erlang:priority_queue:new(),
    PQ1 = erlang:priority_queue:in({0, Start}, PQ),
    dijkstra_loop(N, Graph, Dist1, PQ1).

dijkstra_loop(N, Graph, Dist, PQ) ->
    case erlang:priority_queue:out(PQ) of
        {empty, _} -> {maps:get(N-1, Dist), Dist};
        {{value, {DistNode, Node}}, PQNew} ->
            if
                DistNode > maps:get(Node, Dist) -> dijkstra_loop(N, Graph, Dist, PQNew);
                true ->
                    lists:foreach(fun({Neighbor, Weight}) ->
                        NewDist = DistNode + Weight,
                        if
                            NewDist < maps:get(Neighbor, Dist) ->
                                Dist1 = maps:put(Neighbor, NewDist, Dist),
                                PQ2 = erlang:priority_queue:in({NewDist, Neighbor}, PQNew),
                                dijkstra_loop(N, Graph, Dist1, PQ2);
                            true ->
                                dijkstra_loop(N, Graph, Dist, PQNew)
                        end
                    end, maps:get(Node, Graph, []))
            end
    end.