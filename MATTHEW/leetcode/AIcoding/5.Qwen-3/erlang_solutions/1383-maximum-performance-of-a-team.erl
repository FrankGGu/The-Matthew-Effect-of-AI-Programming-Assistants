-module(maximum_performance).
-export([max_performance/2]).

max_performance(N, Ranks) ->
    max_performance(N, Ranks, 0, 0, []).

max_performance(_, [], Sum, Count, _) when Count == 0 ->
    Sum;
max_performance(N, Ranks, Sum, Count, Heap) when Count < N ->
    [Rank | Rest] = Ranks,
    NewSum = Sum + Rank,
    NewCount = Count + 1,
    {NewHeap, _} = insert_heap(Heap, Rank),
    max_performance(N, Rest, NewSum, NewCount, NewHeap);
max_performance(N, Ranks, Sum, Count, Heap) ->
    [Rank | Rest] = Ranks,
    Min = heap_min(Heap),
    if
        Rank > Min ->
            NewSum = Sum - Min + Rank,
            NewHeap = remove_heap(Heap, Min),
            {NewHeap, _} = insert_heap(NewHeap, Rank),
            max_performance(N, Rest, NewSum, Count, NewHeap);
        true ->
            max_performance(N, Rest, Sum, Count, Heap)
    end.

heap_min([]) -> 0;
heap_min([H | _]) -> H.

insert_heap([], X) -> [X];
insert_heap([H | T], X) when X < H -> [X | [H | T]];
insert_heap([H | T], X) -> [H | insert_heap(T, X)].

remove_heap([], _) -> [];
remove_heap([H | T], X) when H == X -> T;
remove_heap([H | T], X) -> [H | remove_heap(T, X)].