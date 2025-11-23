-module(solution).
-export([reachable_nodes/3]).

reachable_nodes(Edges, M, N) ->
    Graph = build_graph(Edges, N),
    Heap = heap:new(),
    heap:insert(Heap, {0, 0}),
    Dist = maps:from_list([{I, -1} || I <- lists:seq(0, N - 1)]),
    Dist1 = maps:put(0, 0, Dist),
    {Dist2, _} = dijkstra(Graph, Heap, Dist1, M),
    Count = count_reachable_nodes(Dist2, M),
    Count + count_reachable_edges(Edges, Dist2, M).

build_graph(Edges, N) ->
    Graph = [maps:new() || _ <- lists:seq(0, N - 1)],
    lists:foldl(fun([U, V, W], G) ->
        GU = lists:nth(U + 1, G),
        GV = lists:nth(V + 1, G),
        GU1 = maps:put(V, W, GU),
        GV1 = maps:put(U, W, GV),
        lists:sublist(G, U) ++ [GU1] ++ lists:sublist(G, U + 2, N - U - 1),
        lists:sublist(G, V) ++ [GV1] ++ lists:sublist(G, V + 2, N - V - 1)
    end, Graph, Edges).

dijkstra(Graph, Heap, Dist, M) ->
    case heap:is_empty(Heap) of
        true -> {Dist, Heap};
        false ->
            {D, U} = heap:extract(Heap),
            case D > maps:get(U, Dist) of
                true -> dijkstra(Graph, Heap, Dist, M);
                false ->
                    Neighbors = maps:to_list(lists:nth(U + 1, Graph)),
                    {Dist1, Heap1} = lists:foldl(fun({V, W}, {Dst, H}) ->
                        D1 = D + W + 1,
                        case D1 =< M andalso (maps:get(V, Dst) =:= -1 orelse D1 < maps:get(V, Dst)) of
                            true ->
                                Dst1 = maps:put(V, D1, Dst),
                                heap:insert(H, {D1, V}),
                                {Dst1, H};
                            false -> {Dst, H}
                        end
                    end, {Dist, Heap}, Neighbors),
                    dijkstra(Graph, Heap1, Dist1, M)
            end
    end.

count_reachable_nodes(Dist, M) ->
    maps:fold(fun(_, D, Acc) ->
        if D =/= -1 andalso D =< M -> Acc + 1;
           true -> Acc
        end
    end, 0, Dist).

count_reachable_edges(Edges, Dist, M) ->
    lists:foldl(fun([U, V, W], Acc) ->
        DU = maps:get(U, Dist, -1),
        DV = maps:get(V, Dist, -1),
        ReachableU = if DU =:= -1 -> 0; true -> max(0, M - DU) end,
        ReachableV = if DV =:= -1 -> 0; true -> max(0, M - DV) end,
        Acc + min(W, ReachableU + ReachableV)
    end, 0, Edges).