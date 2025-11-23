-module(small_range).
-export([smallest_range/1]).

smallest_range(Lists) ->
    K = length(Lists),
    {Min, Max} = lists:foldl(fun(L, {MinSoFar, MaxSoFar}) ->
                                    [H | _] = L,
                                    {min(H, MinSoFar), max(H, MaxSoFar)}
                            end, {infinity, -infinity}, Lists),
    Heap = lists:foldl(fun(L, Acc) ->
                               [H | _] = L,
                               [{H, 0, L} | Acc]
                       end, [], Lists),
    {CurrentMin, CurrentMax, Heap} = {Min, Max, heapify(Heap)},
    Result = find_smallest_range(K, CurrentMin, CurrentMax, Heap, Lists),
    Result.

find_smallest_range(_, CurrentMin, CurrentMax, _, _) when CurrentMin == infinity -> {CurrentMin, CurrentMax};
find_smallest_range(K, CurrentMin, CurrentMax, Heap, Lists) ->
    {Value, ListIndex, List} = hd(heap:extract_min(Heap)),
    NextList = lists:nth(ListIndex + 1, Lists),
    NewMin = min(CurrentMin, Value),
    NewMax = max(CurrentMax, Value),
    if
        NewMax - NewMin < CurrentMax - CurrentMin ->
            {NewMin, NewMax, heap:insert(Heap, {hd(NextList), ListIndex, NextList})};
        true ->
            {CurrentMin, CurrentMax, heap:insert(Heap, {hd(NextList), ListIndex, NextList})}
    end,
    find_smallest_range(K, NewMin, NewMax, Heap, Lists).

heapify(List) ->
    heap:build_heap(List, fun({A, _, _}, {B, _, _}) -> A =< B end).

-module(heap).
-export([build_heap/2, insert/2, extract_min/1]).

build_heap(List, Compare) ->
    build_heap(List, Compare, []).

build_heap([], _Compare, Heap) ->
    Heap;
build_heap([H | T], Compare, Heap) ->
    build_heap(T, Compare, insert(Heap, H, Compare)).

insert([], Item, _Compare) ->
    [Item];
insert([H | T], Item, Compare) ->
    case Compare(Item, H) of
        true ->
            [Item, H | T];
        false ->
            [H | insert(T, Item, Compare)]
    end.

extract_min([H | T]) ->
    {H, T}.