-module(solution).
-export([count_paths/1]).

count_paths(Roads) ->
    N = length(Roads),
    Adj = build_adjacency_list(Roads, N),
    {Dist, Ways} = dijkstra(Adj, N),
    maps:get(N - 1, Ways, 0) rem 1000000007.

build_adjacency_list(Roads, N) ->
    Adj = lists:duplicate(N, #{}),
    lists:foldl(fun([U, V, Time], Acc) ->
                    Acc1 = update_adj(Acc, U, V, Time),
                    update_adj(Acc1, V, U, Time)
                end, Adj, Roads).

update_adj(Adj, U, V, Time) ->
    case maps:get(V, lists:nth(U + 1, Adj), infinity) of
        infinity ->
            NewMap = maps:put(V, Time, lists:nth(U + 1, Adj)),
            setelement(U + 1, Adj, NewMap);
        ExistingTime when Time < ExistingTime ->
            NewMap = maps:put(V, Time, lists:nth(U + 1, Adj)),
            setelement(U + 1, Adj, NewMap);
        _ ->
            Adj
    end.

dijkstra(Adj, N) ->
    Dist = array:new([{size, N}, {default, infinity}]),
    Dist1 = array:set(0, 0, Dist),
    Ways = maps:from_list([{0, 1}]),
    Heap = heap:new(),
    Heap1 = heap:insert(0, 0, Heap),
    dijkstra_loop(Heap1, Adj, Dist1, Ways, N).

dijkstra_loop(Heap, Adj, Dist, Ways, N) ->
    case heap:is_empty(Heap) of
        true -> {Dist, Ways};
        false ->
            {CurrentDist, U, Heap1} = heap:extract_min(Heap),
            if
                CurrentDist > array:get(U, Dist) ->
                    dijkstra_loop(Heap1, Adj, Dist, Ways, N);
                true ->
                    Neighbors = maps:to_list(lists:nth(U + 1, Adj)),
                    {NewDist, NewWays, NewHeap} = 
                        lists:foldl(fun({V, Time}, {D, W, H}) ->
                            NewDist = CurrentDist + Time,
                            case NewDist < array:get(V, D) of
                                true ->
                                    D1 = array:set(V, NewDist, D),
                                    W1 = maps:put(V, maps:get(U, W, 0), W),
                                    H1 = heap:insert(NewDist, V, H),
                                    {D1, W1, H1};
                                false when NewDist == array:get(V, D) ->
                                    W1 = maps:update_with(V, fun(Count) -> 
                                        (Count + maps:get(U, W, 0)) rem 1000000007 
                                    end, W),
                                    {D, W1, H};
                                false ->
                                    {D, W, H}
                            end
                        end, {Dist, Ways, Heap1}, Neighbors),
                    dijkstra_loop(NewHeap, Adj, NewDist, NewWays, N)
            end
    end.