-module(median_finder).
-export([init/0, addNum/2, findMedian/1]).

init() ->
    {gb_trees:empty(), gb_trees:empty()}.

addNum(Num, {MaxHeap, MinHeap}) ->
    {TempMaxHeap, TempMinHeap} =
        if
            gb_trees:is_empty(MaxHeap) orelse Num =< gb_trees:largest(MaxHeap) ->
                {gb_trees:insert(Num, true, MaxHeap), MinHeap};
            true ->
                {MaxHeap, gb_trees:insert(Num, true, MinHeap)}
        end,

    SizeMax = gb_trees:size(TempMaxHeap),
    SizeMin = gb_trees:size(TempMinHeap),

    if
        SizeMax > SizeMin + 1 ->
            {LargestMax, _, NewMaxHeap} = gb_trees:take_largest(TempMaxHeap),
            NewMinHeap = gb_trees:insert(LargestMax, true, TempMinHeap),
            {NewMaxHeap, NewMinHeap};
        SizeMin > SizeMax ->
            {SmallestMin, _, NewMinHeap} = gb_trees:take_smallest(TempMinHeap),
            NewMaxHeap = gb_trees:insert(SmallestMin, true, TempMaxHeap),
            {NewMaxHeap, NewMinHeap};
        true ->
            {TempMaxHeap, TempMinHeap}
    end.

findMedian({MaxHeap, MinHeap}) ->
    SizeMax = gb_trees:size(MaxHeap),
    SizeMin = gb_trees:size(MinHeap),

    if
        SizeMax == SizeMin ->
            LargestMax = gb_trees:largest(MaxHeap),
            SmallestMin = gb_trees:smallest(MinHeap),
            (LargestMax + SmallestMin) / 2.0;
        SizeMax == SizeMin + 1 ->
            LargestMax = gb_trees:largest(MaxHeap),
            LargestMax / 1.0
    end.