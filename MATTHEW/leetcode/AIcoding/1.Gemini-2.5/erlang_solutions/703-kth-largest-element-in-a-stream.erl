-module(kth_largest_element_in_a_stream).
-export([init/2, add/2]).

init(K, Nums) ->
    % Initial state: K, empty gb_trees, and ID counter starting from 0.
    InitialState = {K, gb_trees:empty(), 0},
    % Fold over the initial numbers to populate the heap.
    % We only care about the final state after processing all initial numbers.
    lists:foldl(fun(Num, AccState) ->
                        % add/2 returns {KthLargestValue, NewState}. We only need NewState here.
                        {_KthLargest, NewState} = add(Num, AccState),
                        NewState
                end, InitialState, Nums).

add(Val, {K, Heap, NextId}) ->
    % Increment the unique ID counter for the new element.
    NewId = NextId + 1,
    % The key for gb_trees is a tuple {Value, UniqueId} to handle duplicate values.
    % gb_trees orders by the first element of the tuple, then the second.
    NewKey = {Val, NewId},

    CurrentSize = gb_trees:size(Heap),

    if
        CurrentSize < K ->
            % If the heap is not yet full, just insert the new element.
            NewHeap = gb_trees:insert(NewKey, Heap),
            % The Kth largest element is the smallest in our min-heap.
            % gb_trees:smallest returns the {Key, Value} tuple. Our Key is {Value, Id}, Value is undefined.
            {{KthLargestVal, _}, _} = gb_trees:smallest(NewHeap),
            % Return the Kth largest value and the updated state.
            {KthLargestVal, {K, NewHeap, NewId}};
        CurrentSize == K ->
            % If the heap is full, compare the new value with the smallest in the heap.
            {{MinValInHeap, _MinIdInHeap}, _} = gb_trees:smallest(Heap),
            if
                Val > MinValInHeap ->
                    % If the new value is larger, remove the smallest element from the heap
                    % and insert the new element.
                    HeapWithoutMin = gb_trees:delete_smallest(Heap),
                    NewHeap = gb_trees:insert(NewKey, HeapWithoutMin),
                    % The Kth largest element is now the smallest in the updated heap.
                    {{KthLargestVal, _}, _} = gb_trees:smallest(NewHeap),
                    {KthLargestVal, {K, NewHeap, NewId}};
                true -> % Val <= MinValInHeap
                    % If the new value is not larger than the smallest in the heap,
                    % it's not among the K largest, so the heap remains unchanged.
                    % The Kth largest element is still the smallest in the current heap.
                    {{KthLargestVal, _}, _} = gb_trees:smallest(Heap),
                    {KthLargestVal, {K, Heap, NewId}}
            end
    end.