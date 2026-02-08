-module(solution).
-export([second_minimum/4]).

second_minimum(N, Edges, Time, Change) ->
    Adj = build_adj(N, Edges),
    {D1, D2} = dijkstra(N, Adj, Time, Change),
    D2.

build_adj(N, Edges) ->
    Adj = lists:duplicate(N + 1, []),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = set_adj(U, V, Acc),
                    set_adj(V, U, Acc1)
                end, Adj, Edges).

set_adj(U, V, Adj) ->
    List = lists:nth(U, Adj),
    NewList = [V | List],
    setelement(U, Adj, NewList).

dijkstra(N, Adj, Time, Change) ->
    D1 = maps:new(),
    D2 = maps:new(),
    Q = [{0, 1}],
    {D1_1, D2_1} = dijkstra_loop(N, Adj, Time, Change, Q, D1, D2),
    {maps:get(N, D1_1), maps:get(N, D2_1)}.

dijkstra_loop(N, Adj, Time, Change, Q, D1, D2) ->
    case Q of
        [] -> {D1, D2};
        [{T, U} | Rest] ->
            case maps:is_key(U, D1) of
                false ->
                    D1_1 = maps:put(U, T, D1),
                    Neighbors = lists:nth(U, Adj),
                    Q1 = update_queue(Neighbors, U, T, Time, Change, Rest, D1_1, D2),
                    dijkstra_loop(N, Adj, Time, Change, Q1, D1_1, D2);
                true ->
                    case maps:get(U, D1) of
                        T -> dijkstra_loop(N, Adj, Time, Change, Rest, D1, D2);
                        _ ->
                            case maps:is_key(U, D2) of
                                false ->
                                    D2_1 = maps:put(U, T, D2),
                                    Neighbors = lists:nth(U, Adj),
                                    Q1 = update_queue(Neighbors, U, T, Time, Change, Rest, D1, D2_1),
                                    dijkstra_loop(N, Adj, Time, Change, Q1, D1, D2_1);
                                true ->
                                    dijkstra_loop(N, Adj, Time, Change, Rest, D1, D2)
                            end
                    end
            end
    end.

update_queue([], _, _, _, _, Q, _, _) -> Q;
update_queue([V | Vs], U, T, Time, Change, Q, D1, D2) ->
    TotalTime = T + Time,
    CurrentTime = TotalTime,
    Green = (CurrentTime div Change) rem 2 == 0,
    WaitTime = case Green of
                   true -> 0;
                   false -> Change - (CurrentTime rem Change)
               end,
    NewTime = CurrentTime + WaitTime + Time,
    Q1 = case maps:is_key(V, D1) of
             false -> insert_sorted(NewTime, V, Q);
             true ->
                 case maps:get(V, D1) of
                     NewTime -> Q;
                     _ ->
                         case maps:is_key(V, D2) of
                             false -> insert_sorted(NewTime, V, Q);
                             true -> Q
                         end
                 end
         end,
    update_queue(Vs, U, T, Time, Change, Q1, D1, D2).

insert_sorted(Time, V, Q) ->
    insert_sorted(Time, V, Q, []).

insert_sorted(Time, V, [], Acc) ->
    lists:reverse([{Time, V} | Acc]);
insert_sorted(Time, V, [{T, U} | Rest], Acc) when Time < T ->
    lists:reverse([{Time, V} | Acc]) ++ [{T, U} | Rest];
insert_sorted(Time, V, [{T, U} | Rest], Acc) ->
    insert_sorted(Time, V, Rest, [{T, U} | Acc]).