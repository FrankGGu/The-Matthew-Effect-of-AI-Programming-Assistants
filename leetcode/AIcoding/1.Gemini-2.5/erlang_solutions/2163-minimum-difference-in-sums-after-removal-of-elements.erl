-module(solution).
-export([minimum_difference/1]).

minimum_difference(Nums) ->
    Len = length(Nums),
    N = Len div 3,

    % Step 1: Calculate min_prefix_sums
    % MinPrefixSums[i] stores the minimum sum of N elements chosen from Nums[0...i].
    % This is valid for i from N-1 to Len-1.
    MinPrefixSums = build_min_prefix_sums(Nums, N),

    % Step 2: Calculate max_suffix_sums
    % MaxSuffixSums[i] stores the maximum sum of N elements chosen from Nums[i...Len-1].
    % This is valid for i from 0 to Len-N.
    MaxSuffixSums = build_max_suffix_sums(Nums, N, Len),

    % Step 3: Combine results
    % Iterate through all possible split points 'i'.
    % 'i' is the last index of the first N elements.
    % The first N elements are chosen from Nums[0...i].
    % The second N elements are chosen from Nums[i+1...Len-1].
    % 'i' ranges from N-1 (smallest possible first part) to 2N-1 (largest possible first part)
    % such that there are at least N elements remaining for the second part (i+1 to Len-1).
    % Len - 1 - (i+1) + 1 >= N  => Len - 1 - i >= N => 3N - 1 - i >= N => 2N - 1 >= i.
    combine_sums(MinPrefixSums, MaxSuffixSums, N).

build_min_prefix_sums(Nums, N) ->
    Len = length(Nums),
    InitialArray = array:new({size, Len}, {default, 0}), % Default value 0 for unused indices
    build_min_prefix_sums_loop(Nums, N, gb_trees:empty(), 0, 0, 0, InitialArray).

build_min_prefix_sums_loop([], _N, _Heap, _CurrentSum, _Counter, _Idx, AccArray) ->
    AccArray;
build_min_prefix_sums_loop([H|T], N, Heap, CurrentSum, Counter, Idx, AccArray) ->
    NewCounter = Counter + 1,
    % Store {Value, Counter} as key to handle duplicates. Value as actual value.
    NewHeap = gb_trees:insert({H, NewCounter}, H, Heap),
    NewCurrentSum = CurrentSum + H,

    {UpdatedHeap, UpdatedSum} =
        if gb_trees:size(NewHeap) > N ->
            {{MaxVal, MaxKeyCounter}, _} = gb_trees:largest(NewHeap), % Get full key
            {gb_trees:delete({MaxVal, MaxKeyCounter}, NewHeap), NewCurrentSum - MaxVal};
        true ->
            {NewHeap, NewCurrentSum}
        end,

    UpdatedArray =
        if gb_trees:size(UpdatedHeap) == N ->
            array:set(Idx, UpdatedSum, AccArray);
        true ->
            AccArray % Indices < N-1 won't be used (they remain as default 0)
        end,
    build_min_prefix_sums_loop(T, N, UpdatedHeap, UpdatedSum, NewCounter, Idx + 1, UpdatedArray).

build_max_suffix_sums(Nums, N, OriginalLen) ->
    InitialArray = array:new({size, OriginalLen}, {default, 0}), % Default value 0 for unused indices
    % Process reversed list to build suffix sums from right to left
    build_max_suffix_sums_loop(lists:reverse(Nums), N, gb_trees:empty(), 0, 0, 0, InitialArray, OriginalLen).

build_max_suffix_sums_loop([], _N, _Heap, _CurrentSum, _Counter, _Idx, AccArray, _OriginalLen) ->
    AccArray;
build_max_suffix_sums_loop([H|T], N, Heap, CurrentSum, Counter, Idx, AccArray, OriginalLen) ->
    NewCounter = Counter + 1,
    NewHeap = gb_trees:insert({H, NewCounter}, H, Heap),
    NewCurrentSum = CurrentSum + H,

    {UpdatedHeap, UpdatedSum} =
        if gb_trees:size(NewHeap) > N ->
            {{MinVal, MinKeyCounter}, _} = gb_trees:smallest(NewHeap), % Get full key
            {gb_trees:delete({MinVal, MinKeyCounter}, NewHeap), NewCurrentSum - MinVal};
        true ->
            {NewHeap, NewCurrentSum}
        end,

    ArrayIdx = OriginalLen - 1 - Idx, % Map current reverse index to original array index
    UpdatedArray =
        if gb_trees:size(UpdatedHeap) == N ->
            array:set(ArrayIdx, UpdatedSum, AccArray);
        true ->
            AccArray % Indices > OriginalLen - N won't be used (they remain as default 0)
        end,
    build_max_suffix_sums_loop(T, N, UpdatedHeap, UpdatedSum, NewCounter, Idx + 1, UpdatedArray, OriginalLen).

combine_sums(MinPrefixSums, MaxSuffixSums, N) ->
    % Iterate 'i' from N-1 to 2N-1 (inclusive)
    % Calculate MinPrefixSums[i] - MaxSuffixSums[i+1]
    % Initialize MinDiff with a very large number (float('inf') works for comparison)
    combine_sums_loop(N - 1, N, MinPrefixSums, MaxSuffixSums, float('inf')).

combine_sums_loop(I, N, MinPrefixSums, MaxSuffixSums, CurrentMinDiff) when I < 2*N ->
    LeftSum = array:get(I, MinPrefixSums),
    RightSum = array:get(I+1, MaxSuffixSums),

    Diff = LeftSum - RightSum,
    NewMinDiff = min(CurrentMinDiff, Diff),

    combine_sums_loop(I + 1, N, MinPrefixSums, MaxSuffixSums, NewMinDiff);
combine_sums_loop(_I, _N, _MinPrefixSums, _MaxSuffixSums, CurrentMinDiff) ->
    CurrentMinDiff.