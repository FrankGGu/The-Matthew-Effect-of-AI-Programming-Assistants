-module(solution).
-export([count_smaller/1]).

count_smaller(Nums) ->
    N = length(Nums),
    %% Create a list of tuples: [{Value, OriginalIndex}]
    IndexedNums = lists:zip(Nums, lists:seq(0, N-1)),
    %% Initialize a counts array with zeros. This array will be updated during merge sort.
    InitialCountsArray = array:new(N, 0),
    %% Perform merge sort and count. The function returns the final sorted list
    %% (which we don't need for the result) and the updated counts array.
    {_FinalSortedList, FinalCountsArray} = merge_sort_and_count(IndexedNums, InitialCountsArray),
    %% Convert the final counts array to a list.
    array:to_list(FinalCountsArray).

merge_sort_and_count(List, Counts) ->
    Len = length(List),
    if
        Len < 2 ->
            %% Base case: A list with 0 or 1 element is already sorted.
            {List, Counts};
        true ->
            %% Split the list into two halves.
            Mid = Len div 2,
            {Left, Right} = lists:split(Mid, List),
            %% Recursively sort the left half.
            {SortedLeft, Counts1} = merge_sort_and_count(Left, Counts),
            %% Recursively sort the right half, passing the counts updated by the left half.
            {SortedRight, Counts2} = merge_sort_and_count(Right, Counts1),
            %% Merge the two sorted halves and update counts based on elements crossing the merge boundary.
            merge(SortedLeft, SortedRight, Counts2)
    end.

merge(L, R, Counts) ->
    merge_impl(L, R, [], 0, Counts).

merge_impl([], R, AccMerged, _RightCount, Counts) ->
    %% If L is exhausted, append remaining R elements to AccMerged (reversed).
    %% No further count updates for elements from L are needed here.
    {lists:reverse(AccMerged, R), Counts};
merge_impl(L, [], AccMerged, RightCount, Counts) ->
    %% If R is exhausted, all remaining elements in L are greater than
    %% all elements already processed from R (which is `RightCount`).
    %% Update counts for all remaining L elements.
    {FinalL, FinalCounts} = merge_add_remaining_left(L, RightCount, Counts, []),
    {lists:reverse(AccMerged, FinalL), FinalCounts};
merge_impl([{LH_Val, LH_Idx}|LT], [{RH_Val, RH_Idx}|RT], AccMerged, RightCount, Counts) ->
    if
        LH_Val =< RH_Val ->
            %% If element from L is smaller or equal, it means RightCount elements
            %% from R (that have already been moved to AccMerged) are smaller than LH_Val.
            %% Update the count for LH_Idx.
            NewCounts = array:set(LH_Idx, array:get(LH_Idx, Counts) + RightCount, Counts),
            merge_impl(LT, [{RH_Val, RH_Idx}|RT], [{LH_Val, LH_Idx}|AccMerged], RightCount, NewCounts);
        true ->
            %% If element from R is smaller, move it to AccMerged and increment RightCount.
            %% This element will be counted against subsequent elements from L.
            merge_impl([{LH_Val, LH_Idx}|LT], RT, [{RH_Val, RH_Idx}|AccMerged], RightCount + 1, Counts)
    end.

merge_add_remaining_left([], _RightCount, Counts, AccLeft) ->
    {lists:reverse(AccLeft), Counts};
merge_add_remaining_left([{Val, Idx}|T], RightCount, Counts, AccLeft) ->
    NewCounts = array:set(Idx, array:get(Idx, Counts) + RightCount, Counts),
    merge_add_remaining_left(T, RightCount, NewCounts, [{Val, Idx}|AccLeft]).