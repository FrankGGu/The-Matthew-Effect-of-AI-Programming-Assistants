-module(count_valid_paths).
-export([count_valid_paths/2]).

count_valid_paths(N, Edges) ->
    Graph = create_graph(N, Edges),
    count_paths(Graph, N).

create_graph(N, Edges) ->
    create_graph(N, Edges, lists:seq(1, N), []).

create_graph(_, [], [], Acc) ->
    Acc;
create_graph(N, [], Nodes, Acc) ->
    lists:foldl(fun(Node, Graph) ->
                        maps:put(Node, [], Graph)
                end, maps:from_list([]), Nodes);
create_graph(N, [[U, V] | Rest], Nodes, Acc) ->
    Graph = case Acc of
                [] ->
                    maps:from_list([{U, [V]}, {V, [U]}]);
                _ ->
                    case maps:is_key(U, Acc) of
                        true ->
                            case maps:is_key(V, Acc) of
                                true ->
                                    UList = maps:get(U, Acc),
                                    VList = maps:get(V, Acc),
                                    maps:put(U, [V | UList], maps:put(V, [U | VList], Acc));
                                false ->
                                    UList = maps:get(U, Acc),
                                    maps:put(U, [V | UList], maps:put(V, [U], Acc));
                            end;
                        false ->
                            case maps:is_key(V, Acc) of
                                true ->
                                    VList = maps:get(V, Acc),
                                    maps:put(V, [U | VList], maps:put(U, [V], Acc));
                                false ->
                                    maps:put(U, [V], maps:put(V, [U], Acc))
                            end
                    end,
    create_graph(N, Rest, Nodes, Graph).

count_paths(Graph, N) ->
    Primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97],
    count_paths(Graph, N, Primes, 0).

count_paths(Graph, N, Primes, Acc) ->
    lists:foldl(fun(StartNode, Acc1) ->
                        Acc1 + count_paths_from(Graph, StartNode, Primes)
                end, 0, lists:seq(1, N)).

count_paths_from(Graph, StartNode, Primes) ->
    count_paths_from(Graph, StartNode, Primes, maps:from_list([{StartNode, true}]), 0).

count_paths_from(Graph, CurrentNode, Primes, Visited, Acc) ->
    Neighbors = maps:get(CurrentNode, Graph),
    lists:foldl(fun(Neighbor, Acc1) ->
                        case maps:is_key(Neighbor, Visited) of
                            true ->
                                Acc1;
                            false ->
                                case lists:member(Neighbor, Primes) of
                                    true ->
                                        Acc1;
                                    false ->
                                        Acc1 + 1 + count_paths_from(Graph, Neighbor, Primes, maps:put(Neighbor, true, Visited), 0)
                                end
                        end
                end, Acc, Neighbors).