-module(solution).
-export([modified_graph_edges/4]).

modified_graph_edges(N, Edges, Source, Destination) ->
    Adj = build_adjacency(N, Edges),
    {Dist, Parent} = dijkstra(N, Adj, Source),
    case lists:nth(Destination, Dist) of -1 -> -1;
        _ -> 
            NewEdges = modify_edges(Edges, Parent, Destination, Source),
            NewAdj = build_adjacency(N, NewEdges),
            {NewDist, _} = dijkstra(N, NewAdj, Source),
            case lists:nth(Destination, NewDist) of
                -1 -> -1;
                _ -> NewEdges
            end
    end.

build_adjacency(N, Edges) ->
    Adj = lists:duplicate(N + 1, []),
    lists:foldl(fun({U, V, W}, Acc) ->
                    update_adj(Acc, U, V, W),
                    update_adj(Acc, V, U, W)
                end, Adj, Edges).

update_adj(Adj, U, V, W) ->
    Existing = lists:nth(U, Adj),
    lists:sublist(Adj, U - 1) ++ [[{V, W} | Existing]] ++ lists:nthtail(U, Adj).

dijkstra(N, Adj, Source) ->
    Dist = lists:duplicate(N + 1, -1),
    Parent = lists:duplicate(N + 1, -1),
    Dist1 = setelement(Source, list_to_tuple(Dist), 0),
    Q = [{0, Source}],
    dijkstra_loop(N, Adj, Q, Dist1, Parent).

dijkstra_loop(N, Adj, Q, Dist, Parent) ->
    case Q of
        [] -> {tuple_to_list(Dist), Parent};
        [{D, U} | Rest] ->
            case D > element(U, Dist) of
                true -> dijkstra_loop(N, Adj, Rest, Dist, Parent);
                false ->
                    Neighbors = lists:nth(U, Adj),
                    {NewDist, NewParent, NewQ} = 
                        lists:foldl(fun({V, W}, {Dst, Prt, Que}) ->
                                        Alt = D + W,
                                        case Alt < element(V, Dst) of
                                            true ->
                                                Dst1 = setelement(V, Dst, Alt),
                                                Prt1 = setelement(V, Prt, U),
                                                Que1 = [{Alt, V} | Que],
                                                {Dst1, Prt1, Que1};
                                            false -> {Dst, Prt, Que}
                                        end
                                    end, {Dist, Parent, Rest}, Neighbors),
                    dijkstra_loop(N, Adj, NewQ, NewDist, NewParent)
            end
    end.

modify_edges(Edges, Parent, Destination, Source) ->
    Path = get_path(Parent, Destination, Source, []),
    Modified = lists:foldl(fun({U, V}, Acc) ->
                                case lists:keyfind({U, V}, 1, Acc) of
                                    false -> 
                                        case lists:keyfind({V, U}, 1, Acc) of
                                            false -> Acc;
                                            {V1, U1, W1} -> 
                                                lists:keyreplace({V1, U1}, 1, Acc, {V1, U1, 1})
                                        end;
                                    {U1, V1, W1} -> 
                                        lists:keyreplace({U1, V1}, 1, Acc, {U1, V1, 1})
                                end
                            end, Edges, Path),
    Modified.

get_path(Parent, V, Source, Path) ->
    case V =:= Source of
        true -> Path;
        false ->
            U = lists:nth(V, Parent),
            get_path(Parent, U, Source, [{U, V} | Path])
    end.