-spec min_groups(Intervals :: [[integer()]]) -> integer().
min_groups(Intervals) ->
    Sorted = lists:sort(fun([A, _], [B, _]) -> A =< B end, Intervals),
    process(Sorted, []).

process([], Heap) ->
    length(Heap);
process([[Start, End] | Rest], Heap) ->
    case Heap of
        [] ->
            NewHeap = heap:insert(End, heap:new());
        [MinEnd | _] when Start > MinEnd ->
            NewHeap = heap:insert(End, heap:delete_min(Heap));
        _ ->
            NewHeap = heap:insert(End, Heap)
    end,
    process(Rest, NewHeap).