-spec max_instances(intervals :: [[integer()]]) -> integer().
max_instances(Intervals) ->
    Sorted = lists:sort(fun([A, _], [B, _]) -> A =< B end, Intervals),
    process(Sorted, [], 0).

process([], Heap, Count) -> Count;
process([[S, E] | Rest], Heap, Count) ->
    case Heap of
        [] -> 
            NewHeap = heap:insert(E, heap:new()),
            process(Rest, NewHeap, Count + 1);
        _ ->
            {MinE, NewHeap0} = heap:take_min(Heap),
            if 
                S >= MinE ->
                    NewHeap = heap:insert(E, NewHeap0),
                    process(Rest, NewHeap, Count);
                true ->
                    NewHeap1 = heap:insert(MinE, NewHeap0),
                    NewHeap2 = heap:insert(E, NewHeap1),
                    process(Rest, NewHeap2, Count + 1)
            end
    end.