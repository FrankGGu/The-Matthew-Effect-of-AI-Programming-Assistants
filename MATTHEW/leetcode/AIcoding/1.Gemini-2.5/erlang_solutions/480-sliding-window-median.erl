-module(solution).
-export([medianSlidingWindow/2]).

medianSlidingWindow(Nums, K) ->
    Arr = array:from_list(Nums),
    Len = array:size(Arr),
    InitialMaxHeap = {gb_trees:empty(), 0}, % {Tree, Count}
    InitialMinHeap = {gb_trees:empty(), 0}, % {Tree, Count}

    %% Process windows recursively, accumulating results in reverse order.
    process_windows(0, Len, K, Arr, InitialMaxHeap, InitialMinHeap, []).

process_windows(I, Len, K, Arr, MaxHeap, MinHeap, Acc) when I < Len ->
    Val = array:get(I, Arr),

    %% Add the current element to the appropriate heap and balance.
    {NewMaxHeap1, NewMinHeap1} = add_element(Val, MaxHeap, MinHeap),
    {NewMaxHeap2, NewMinHeap2} = balance_heaps(NewMaxHeap1, NewMinHeap1),

    %% If the window is full, calculate the median and add it to the accumulator.
    CurrentAcc = 
        if I >= K - 1 -> 
            Median = calculate_median(NewMaxHeap2, NewMinHeap2, K),
            [Median | Acc];
        true -> Acc
        end,

    %% If the window is full, remove the element that is sliding out.
    {FinalMaxHeap, FinalMinHeap} = 
        if I >= K - 1 ->
            OldVal = array:get(I - K + 1, Arr),
            {NewMaxHeap3, NewMinHeap3} = remove_element(OldVal, NewMaxHeap2, NewMinHeap2),
            balance_heaps(NewMaxHeap3, NewMinHeap3);
        true -> {NewMaxHeap2, NewMinHeap2}
        end,

    %% Continue to the next element.
    process_windows(I + 1, Len, K, Arr, FinalMaxHeap, FinalMinHeap, CurrentAcc);
process_windows(_I, _Len, _K, _Arr, _MaxHeap, _MinHeap, Acc) ->
    %% All elements processed, reverse the accumulated results.
    lists:reverse(Acc).

add_element(Val, {MaxTree, MaxCount}, {MinTree, MinCount}) ->
    if MaxCount == 0 -> % If MaxHeap is empty, add to it.
        {{gb_trees_add(Val, MaxTree), MaxCount + 1}, {MinTree, MinCount}};
    true ->
        LargestMaxVal = gb_trees:largest(MaxTree),
        if Val =< LargestMaxVal -> % If Val is smaller than or equal to MaxHeap's largest, add to MaxHeap.
            {{gb_trees_add(Val, MaxTree), MaxCount + 1}, {MinTree, MinCount}};
        true -> % Otherwise, add to MinHeap.
            {{MaxTree, MaxCount}, {gb_trees_add(Val, MinTree), MinCount + 1}}
        end
    end.

remove_element(Val, {MaxTree, MaxCount}, {MinTree, MinCount}) ->
    if gb_trees:is_member(Val, MaxTree) -> % Check if Val is in MaxTree.
        {{gb_trees_remove(Val, MaxTree), MaxCount - 1}, {MinTree, MinCount}};
    true -> % Otherwise, it must be in MinTree.
        {{MaxTree, MaxCount}, {gb_trees_remove(Val, MinTree), MinCount - 1}}
    end.

balance_heaps({MaxTree, MaxCount}, {MinTree, MinCount}) ->
    if MaxCount > MinCount + 1 ->
        %% MaxHeap is too large, move its largest element to MinHeap.
        LargestMaxVal = gb_trees:largest(MaxTree),
        {value, ValCount} = gb_trees:lookup(LargestMaxVal, MaxTree),
        NewMaxTree = gb_trees:delete(LargestMaxVal, MaxTree),
        NewMinTree = gb_trees_add_exact_count(LargestMaxVal, ValCount, MinTree),
        balance_heaps({NewMaxTree, MaxCount - ValCount}, {NewMinTree, MinCount + ValCount});
    MinCount > MaxCount ->
        %% MinHeap is too large, move its smallest element to MaxHeap.
        SmallestMinVal = gb_trees:smallest(MinTree),
        {value, ValCount} = gb_trees:lookup(SmallestMinVal, MinTree),
        NewMinTree = gb_trees:delete(SmallestMinVal, MinTree),
        NewMaxTree = gb_trees_add_exact_count(SmallestMinVal, ValCount, MaxTree),
        balance_heaps({NewMaxTree, MaxCount + ValCount}, {NewMinTree, MinCount - ValCount});
    true ->
        %% Heaps are balanced.
        {{MaxTree, MaxCount}, {MinTree, MinCount}}
    end.

gb_trees_add(Val, Tree) ->
    case gb_trees:lookup(Val, Tree) of
        {value, Count} -> gb_trees:update(Val, Count + 1, Tree);
        none -> gb_trees:insert(Val, 1, Tree)
    end.

gb_trees_remove(Val, Tree) ->
    {value, Count} = gb_trees:lookup(Val, Tree), 
    if Count > 1 -> gb_trees:update(Val, Count - 1, Tree);
    true -> gb_trees:delete(Val, Tree)
    end.

gb_trees_add_exact_count(Val, Count, Tree) ->
    case gb_trees:lookup(Val, Tree) of
        {value, OldCount} -> gb_trees:update(Val, OldCount + Count, Tree);
        none -> gb_trees:insert(Val, Count, Tree)
    end.

calculate_median({MaxTree, _MaxCount}, {MinTree, _MinCount}, K) ->
    if K rem 2 == 1 -> % Odd number of elements: median is the largest in MaxHeap.
        float(gb_trees:largest(MaxTree));
    true -> % Even number of elements: median is the average of largest in MaxHeap and smallest in MinHeap.
        Val1 = gb_trees:largest(MaxTree),
        Val2 = gb_trees:smallest(MinTree),
        (float(Val1) + float(Val2)) / 2.0
    end.