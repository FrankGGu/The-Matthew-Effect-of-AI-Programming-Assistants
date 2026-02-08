-module(solution).
-export([minimum_weight/4]).

minimum_weight(N, Edges, Src1, Src2) ->
    Graph = build_graph(N, Edges),
    {Dist1, Dist2} = {dijkstra(N, Src1, Graph), dijkstra(N, Src2, Graph)},
    Ans = lists:min([Dist1[D] + Dist2[D] || D <- lists:seq(1, N)]),
    case Ans of
        infinity -> -1;
        _ -> Ans
    end.

build_graph(N, Edges) ->
    Graph = array:new([{size, N + 1}, {default, []}]),
    lists:foldl(fun([U, V, W], G) ->
                    Neighbors = array:get(U, G),
                    array:set(U, [{V, W} | Neighbors], G)
                end, Graph, Edges).

dijkstra(N, Start, Graph) ->
    Dist = array:new([{size, N + 1}, {default, infinity}]),
    Dist1 = array:set(Start, 0, Dist),
    Heap = heap:new([{type, min}]),
    Heap1 = heap:insert({0, Start}, Heap),
    dijkstra_loop(Heap1, Dist1, Graph).

dijkstra_loop(Heap, Dist, Graph) ->
    case heap:is_empty(Heap) of
        true -> Dist;
        false ->
            {{D, U}, Heap1} = heap:extract(Heap),
            case D > array:get(U, Dist) of
                true -> dijkstra_loop(Heap1, Dist, Graph);
                false ->
                    Neighbors = array:get(U, Graph),
                    {Dist1, Heap2} = lists:foldl(fun({V, W}, {Dst, Hp}) ->
                        NewDist = D + W,
                        case NewDist < array:get(V, Dst) of
                            true ->
                                {array:set(V, NewDist, Dst), heap:insert({NewDist, V}, Hp)};
                            false -> {Dst, Hp}
                        end
                    end, {Dist, Heap1}, Neighbors),
                    dijkstra_loop(Heap2, Dist1, Graph)
            end
    end.