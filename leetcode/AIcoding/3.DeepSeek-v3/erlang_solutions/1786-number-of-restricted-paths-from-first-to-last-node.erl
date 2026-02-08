-module(solution).
-export([count_restricted_paths/1]).

count_restricted_paths(N, Edges) ->
    Graph = build_graph(N, Edges),
    Dist = dijkstra(N, Graph),
    Memo = maps:new(),
    {Ans, _} = dfs(1, N, Dist, Graph, Memo),
    Ans.

build_graph(N, Edges) ->
    Graph = maps:new(),
    lists:foldl(fun([U, V, W], G) ->
                    G1 = maps:update_with(U, fun(Neighs) -> [{V, W} | Neighs] end, [{V, W}], G),
                    maps:update_with(V, fun(Neighs) -> [{U, W} | Neighs] end, [{U, W}], G1)
                end, Graph, Edges).

dijkstra(N, Graph) ->
    Dist = array:new(N, {default, infinity}),
    Dist1 = array:set(N, 0, Dist),
    Heap = heap:new(),
    Heap1 = heap:insert({0, N}, Heap),
    dijkstra_loop(Heap1, Graph, Dist1).

dijkstra_loop(Heap, Graph, Dist) ->
    case heap:is_empty(Heap) of
        true -> Dist;
        false ->
            {{D, U}, Heap1} = heap:extract_min(Heap),
            case D > array:get(U, Dist) of
                true -> dijkstra_loop(Heap1, Graph, Dist);
                false ->
                    Neighs = maps:get(U, Graph, []),
                    {Dist1, Heap2} = lists:foldl(fun({V, W}, {Dst, H}) ->
                        NewDist = D + W,
                        case NewDist < array:get(V, Dst) of
                            true ->
                                Dst1 = array:set(V, NewDist, Dst),
                                H1 = heap:insert({NewDist, V}, H),
                                {Dst1, H1};
                            false -> {Dst, H}
                        end
                    end, {Dist, Heap1}, Neighs),
                    dijkstra_loop(Heap2, Graph, Dist1)
            end
    end.

dfs(U, N, Dist, Graph, Memo) ->
    case maps:get(U, Memo, undefined) of
        undefined ->
            if
                U == N -> {1, Memo};
                true ->
                    Neighs = maps:get(U, Graph, []),
                    {Sum, Memo1} = lists:foldl(fun({V, _}, {Acc, M}) ->
                        case array:get(V, Dist) < array:get(U, Dist) of
                            true ->
                                {Cnt, M1} = dfs(V, N, Dist, Graph, M),
                                {(Acc + Cnt) rem 1000000007, M1};
                            false -> {Acc, M}
                        end
                    end, {0, Memo}, Neighs),
                    {Sum, maps:put(U, Sum, Memo1)}
            end;
        Cached -> {Cached, Memo}
    end.