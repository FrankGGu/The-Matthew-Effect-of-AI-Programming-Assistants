-module(find_minimum_log_transportation_cost).
-export([min_cost/2]).

min_cost(N, Edges) ->
    Graph = build_graph(N, Edges),
    dist(1, N, Graph).

build_graph(N, Edges) ->
    lists:foldl(
        fun({U, V, W}, Acc) ->
            Acc#{
                U => lists:append(maps:get(U, Acc, []), [{V, W}]),
                V => lists:append(maps:get(V, Acc, []), [{U, W}])
            }
        end,
        #{},
        Edges
    ).

dist(Start, End, Graph) ->
    Dists = #{Start => 0},
    Q = priority_queue:new(),
    Q1 = priority_queue:insert(Start, 0, Q),
    dijkstra(End, Graph, Dists, Q1).

dijkstra(End, Graph, Dists, Q) ->
    case priority_queue:is_empty(Q) of
        true ->
            case maps:is_key(End, Dists) of
                true -> maps:get(End, Dists);
                false -> -1
            end;
        false ->
            {U, Dist, Q2} = priority_queue:delete_min(Q),
            Neighbors = maps:get(U, Graph, []),
            {NewDists, NewQ} = lists:foldl(
                fun({V, W}, {AccDists, AccQ}) ->
                    NewDist = Dist + W,
                    case maps:is_key(V, AccDists) of
                        true ->
                            OldDist = maps:get(V, AccDists);
                            case NewDist < OldDist of
                                true ->
                                    {AccDists#{V => NewDist}, priority_queue:update(V, NewDist, AccQ)};
                                false ->
                                    {AccDists, AccQ}
                            end;
                        false ->
                            {AccDists#{V => NewDist}, priority_queue:insert(V, NewDist, AccQ)}
                    end
                end,
                {Dists, Q2},
                Neighbors
            ),
            dijkstra(End, Graph, NewDists, NewQ)
    end.