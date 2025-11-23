-module(median_finder).
-export([init/0, addNum/2, findMedian/1]).

heap_new() -> empty.

heap_is_empty(empty) -> true;
heap_is_empty(_) -> false.

heap_rank(empty) -> 0;
heap_rank({R, _, _, _}) -> R.

heap_make_node(V, L, R) ->
    if heap_rank(L) >= heap_rank(R) -> {heap_rank(R) + 1, V, L, R};
       true -> {heap_rank(L) + 1, V, R, L}
    end.

heap_merge(empty, H) -> H;
heap_merge(H, empty) -> H;
heap_merge({R1, V1, L1, R1_child}, {R2, V2, L2, R2_child}) when V1 =< V2 ->
    heap_make_node(V1, L1, heap_merge(R1_child, {R2, V2, L2, R2_child}));
heap_merge(H1, H2) ->
    heap_merge(H2, H1).

heap_insert(X, H) ->
    heap_merge(heap_make_node(X, empty, empty), H).

heap_find_min(empty) -> error(empty_heap);
heap_find_min({_, V, _, _}) -> V.

heap_delete_min(empty) -> error(empty_heap);
heap_delete_min({_, _, L, R}) -> heap_merge(L, R).

init() ->
    {heap_new(), heap_new(), 0, 0}.

addNum(Num, {MaxH, MinH, MaxS, MinS}) ->
    {TempMaxH, TempMinH, TempMaxS, TempMinS} =
        if MaxS == 0 orelse Num =< -heap_find_min(MaxH) ->
            {heap_insert(-Num, MaxH), MinH, MaxS + 1, MinS};
        true ->
            {MaxH, heap_insert(Num, MinH), MaxS, MinS + 1}
        end,

    balance({TempMaxH, TempMinH, TempMaxS, TempMinS}).

findMedian({MaxH, MinH, MaxS, MinS}) ->
    if MaxS > MinS ->
        float(-heap_find_min(MaxH));
    MaxS == MinS ->
        (float(-heap_find_min(MaxH)) + float(heap_find_min(MinH))) / 2.0;
    true ->
        error(invalid_state_for_median_finder)
    end.

balance({MaxH, MinH, MaxS, MinS}) ->
    if MaxS > MinS + 1 ->
        MaxVal = -heap_find_min(MaxH),
        NewMaxH = heap_delete_min(MaxH),
        NewMinH = heap_insert(MaxVal, MinH),
        {NewMaxH, NewMinH, MaxS - 1, MinS + 1};
    MinS > MaxS ->
        MinVal = heap_find_min(MinH),
        NewMinH = heap_delete_min(MinH),
        NewMaxH = heap_insert(-MinVal, MaxH),
        {NewMaxH, NewMinH, MaxS + 1, MinS - 1};
    true ->
        {MaxH, MinH, MaxS, MinS}
    end.