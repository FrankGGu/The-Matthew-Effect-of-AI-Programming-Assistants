-module(solution).
-export([minimum_time/3]).

minimum_time(N, Edges, Disappear) ->
    Graph = build_graph(N, Edges),
    Dist = array:new(N, {default, infinity}),
    Dist1 = array:set(0, 0, Dist),
    Heap = heap:new(),
    Heap1 = heap:insert({0, 0}, Heap),
    dijkstra(Graph, Heap1, Dist1, Disappear).

build_graph(N, Edges) ->
    Graph = array:new(N, {default, []}),
    lists:foldl(fun([U, V, T], G) ->
                    Neighbors = array:get(U, G),
                    G1 = array:set(U, [{V, T} | Neighbors], G),
                    NeighborsV = array:get(V, G1),
                    array:set(V, [{U, T} | NeighborsV], G1)
                end, Graph, Edges).

dijkstra(Graph, Heap, Dist, Disappear) ->
    case heap:is_empty(Heap) of
        true -> 
            Result = array:to_list(Dist),
            lists:map(fun(infinity) -> -1; (X) -> X end, Result);
        false ->
            {{Time, U}, Heap1} = heap:extract(Heap),
            case Time > array:get(U, Dist) of
                true -> dijkstra(Graph, Heap1, Dist, Disappear);
                false ->
                    lists:foldl(fun({V, T}, {H, D}) ->
                        NewTime = Time + T,
                        if 
                            NewTime < Disappear[V + 1] andalso NewTime < array:get(V, D) ->
                                D1 = array:set(V, NewTime, D),
                                H1 = heap:insert({NewTime, V}, H),
                                {H1, D1};
                            true -> {H, D}
                        end
                    end, {Heap1, Dist}, array:get(U, Graph)),
                    dijkstra(Graph, Heap1, Dist, Disappear)
            end
    end.