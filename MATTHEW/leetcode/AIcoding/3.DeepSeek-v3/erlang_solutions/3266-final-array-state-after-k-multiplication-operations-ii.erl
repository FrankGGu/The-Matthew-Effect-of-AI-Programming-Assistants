-module(solution).
-export([maximum_product/2]).

maximum_product(Nums, K) ->
    Heap = build_max_heap(Nums),
    {Result, _} = perform_operations(Heap, K),
    Result.

build_max_heap(List) ->
    lists:foldl(fun heap_insert/2, [], List).

heap_insert(Val, Heap) ->
    heap_insert(Val, Heap, []).

heap_insert(Val, [], Acc) ->
    lists:reverse([Val | Acc]);
heap_insert(Val, [H | T], Acc) when Val > H ->
    heap_insert(H, T, [Val | Acc]);
heap_insert(Val, [H | T], Acc) ->
    lists:reverse([H | Acc]) ++ [Val | T].

perform_operations(Heap, 0) ->
    {lists:foldl(fun(X, Acc) -> (X * Acc) rem 1000000007 end, 1, Heap), Heap};
perform_operations(Heap, K) ->
    [Max | Rest] = Heap,
    NewHeap = heap_insert(Max + 1, Rest),
    perform_operations(NewHeap, K - 1).