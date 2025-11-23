-module(solution).
-export([minimum_weight/4]).

minimum_weight(N, Edges, Src1, Src2) ->
    Graph = build_graph(N, Edges),
    D1 = dijkstra(N, Src1, Graph),
    D2 = dijkstra(N, Src2, Graph),
    {Dst, _} = lists:last(Graph),
    D3 = dijkstra(N, Dst, build_reverse_graph(N, Edges)),
    Ans = lists:min([D1[I] + D2[I] + D3[I] || I <- lists:seq(1, N)]),
    case Ans >= 16#3f3f3f3f of
        true -> -1;
        false -> Ans
    end.

build_graph(N, Edges) ->
    G = lists:foldl(fun({U, V, W}, Acc) ->
                        maps:update_with(U, fun(L) -> [{V, W} | L] end, [{V, W}], Acc)
                    end, maps:from_list([{I, []} || I <- lists:seq(1, N)]), Edges),
    maps:to_list(G).

build_reverse_graph(N, Edges) ->
    G = lists:foldl(fun({U, V, W}, Acc) ->
                        maps:update_with(V, fun(L) -> [{U, W} | L] end, [{U, W}], Acc)
                    end, maps:from_list([{I, []} || I <- lists:seq(1, N)]), Edges),
    maps:to_list(G).

dijkstra(N, Src, Graph) ->
    Dist = array:new(N, {default, 16#3f3f3f3f}),
    Dist1 = array:set(Src, 0, Dist),
    Q = gb_sets:from_list([{0, Src}]),
    dijkstra_loop(Q, Dist1, Graph).

dijkstra_loop(Q, Dist, Graph) ->
    case gb_sets:is_empty(Q) of
        true -> Dist;
        false ->
            {{D, U}, Q1} = gb_sets:take_smallest(Q),
            case D > array:get(U, Dist) of
                true -> dijkstra_loop(Q1, Dist, Graph);
                false ->
                    Neighbors = proplists:get_value(U, Graph, []),
                    {Dist1, Q2} = lists:foldl(fun({V, W}, {D0, Q0}) ->
                        NewDist = D + W,
                        case NewDist < array:get(V, D0) of
                            true ->
                                D1 = array:set(V, NewDist, D0),
                                Q1 = gb_sets:add({NewDist, V}, Q0),
                                {D1, Q1};
                            false -> {D0, Q0}
                        end
                    end, {Dist, Q1}, Neighbors),
                    dijkstra_loop(Q2, Dist1, Graph)
            end
    end.