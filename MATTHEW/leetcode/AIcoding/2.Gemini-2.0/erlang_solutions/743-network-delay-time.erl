-module(network_delay_time).
-export([network_delay_time/3]).

network_delay_time(Times, N, K) ->
    graph(Times, Graph),
    dijkstra(Graph, N, K).

graph(Times, Graph) ->
    lists:foldl(fun([U, V, W], Acc) ->
                        maps:update_with(U, fun(Edges) -> [{V, W} | Edges] end, [{V, W}], Acc)
                end, #{}, Times).

dijkstra(Graph, N, K) ->
    dijkstra_helper(Graph, N, K, #{}, #{K => 0}).

dijkstra_helper(Graph, N, Seen, Distances, Queue) ->
    case maps:is_empty(Queue) of
        true ->
            case maps:size(Distances) == N of
                true ->
                    lists:max(maps:values(Distances));
                false ->
                    -1
            end;
        false ->
            {U, D} = find_min(Queue),
            NewQueue = maps:remove(U, Queue),
            case maps:is_key(U, Seen) of
                true ->
                    dijkstra_helper(Graph, N, Seen, Distances, NewQueue);
                false ->
                    NewSeen = maps:put(U, true, Seen),
                    Neighbors = maps:get(U, Graph, []),
                    NewDistances = lists:foldl(
                        fun({V, W}, AccDistances) ->
                            NewDistance = D + W,
                            OldDistance = maps:get(V, AccDistances, infinity),
                            if NewDistance < OldDistance ->
                                maps:put(V, NewDistance, AccDistances);
                            true ->
                                AccDistances
                            end
                        end,
                        Distances,
                        Neighbors
                    ),
                    NewQueue2 = lists:foldl(
                        fun({V, _}, AccQueue) ->
                            NewDistance = maps:get(V, NewDistances, infinity),
                            OldDistance = maps:get(V, AccQueue, infinity),
                            if NewDistance < OldDistance ->
                                maps:put(V, NewDistance, AccQueue);
                            true ->
                                AccQueue
                            end
                        end,
                        NewQueue,
                        Neighbors
                    ),
                    dijkstra_helper(Graph, N, NewSeen, NewDistances, NewQueue2)
            end
    end.

find_min(Queue) ->
    lists:foldl(fun({K, V}, {MinK, MinV}) ->
                        if V < MinV ->
                            {K, V};
                        true ->
                            {MinK, MinV}
                        end
                end, {maps:keys(Queue, [1]) -- [], infinity}, maps:to_list(Queue)).