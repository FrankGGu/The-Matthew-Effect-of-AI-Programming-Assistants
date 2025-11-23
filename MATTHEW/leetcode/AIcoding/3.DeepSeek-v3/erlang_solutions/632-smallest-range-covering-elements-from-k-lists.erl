-spec smallest_range([[integer()]]) -> [integer()].
smallest_range(Nums) ->
    K = length(Nums),
    MinHeap = lists:foldl(fun(List, Acc) ->
        [H | _] = List,
        heap:insert(Acc, {H, List, 0})
    end, heap:new(), Nums),
    {Min, Max} = get_min_max(MinHeap, -infinity),
    Range = Max - Min,
    Ans = {Min, Max},
    search(MinHeap, K, Range, Ans).

get_min_max(Heap, CurrentMax) ->
    {MinVal, List, Index} = heap:get_min(Heap),
    NewMax = max(MinVal, CurrentMax),
    {MinVal, NewMax}.

search(Heap, K, CurrentRange, {CurrentMin, CurrentMax}) ->
    case heap:size(Heap) < K of
        true -> [CurrentMin, CurrentMax];
        false ->
            {MinVal, List, Index} = heap:extract_min(Heap),
            case Index + 1 >= length(List) of
                true -> [CurrentMin, CurrentMax];
                false ->
                    NextVal = lists:nth(Index + 2, List),
                    NewHeap = heap:insert(Heap, {NextVal, List, Index + 1}),
                    {NewMin, NewMax} = get_min_max(NewHeap, CurrentMax),
                    NewRange = NewMax - NewMin,
                    if
                        NewRange < CurrentRange ->
                            search(NewHeap, K, NewRange, {NewMin, NewMax});
                        true ->
                            search(NewHeap, K, CurrentRange, {CurrentMin, CurrentMax})
                    end
            end
    end.

heap:new() -> [].

heap:insert([], Elem) -> [Elem];
heap:insert([H | T], Elem) ->
    case element(1, H) =< element(1, Elem) of
        true -> [H | heap:insert(T, Elem)];
        false -> [Elem, H | T]
    end.

heap:get_min([H | _]) -> H.

heap:extract_min([H | T]) -> {H, T}.

heap:size([]) -> 0;
heap:size([_ | T]) -> 1 + heap:size(T).