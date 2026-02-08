-module(solution).
-export([solve/1]).

solve(Nums) ->
    N = length(Nums),
    Arr = array:from_list(Nums),
    TotalSubarrays = N * (N + 1) div 2,

    %% The median is defined as the element at index (total_subarrays - 1) / 2 (0-indexed).
    %% This corresponds to the ((total_subarrays - 1) / 2 + 1)-th smallest element (1-indexed rank).
    TargetRank = (TotalSubarrays - 1) div 2 + 1,

    %% Binary search for the median uniqueness value in the range [1, N].
    binary_search_loop(1, N, N, Arr, N, TargetRank).

binary_search_loop(Low, High, Ans, Arr, N, TargetRank) ->
    if Low > High ->
        Ans;
    true ->
        Mid = Low + (High - Low) div 2,
        %% Count how many subarrays have at most Mid distinct elements.
        Count = count_subarrays(Arr, N, Mid),

        if Count >= TargetRank ->
            %% Mid could be the answer, or the answer is smaller. Try left half.
            binary_search_loop(Low, Mid - 1, Mid, Arr, N, TargetRank);
        true ->
            %% Mid is too small, the answer must be larger. Try right half.
            binary_search_loop(Mid + 1, High, Ans, Arr, N, TargetRank)
        end
    end.

count_subarrays(Arr, N, MaxDistinct) ->
    %% Initial call to the recursive loop.
    %% Left: left pointer index.
    %% Right: right pointer index.
    %% FreqMap: frequency map of elements in the current window [Left..Right-1].
    %% DistinctCount: number of distinct elements in the current window.
    %% TotalCount: accumulated count of valid subarrays.
    count_subarrays_loop(0, 0, maps:new(), 0, 0, Arr, N, MaxDistinct).

count_subarrays_loop(Left, Right, FreqMap, DistinctCount, TotalCount, Arr, N, MaxDistinct) ->
    if Right >= N ->
        TotalCount; %% Base case: right pointer has reached the end of the array.
    true ->
        %% Expand the window to the right.
        NumR = array:get(Right, Arr),
        FreqR = maps:get(NumR, FreqMap, 0),
        NewFreqMap1 = maps:put(NumR, FreqR + 1, FreqMap),
        NewDistinctCount1 = if FreqR == 0 -> DistinctCount + 1; true -> DistinctCount end,

        %% Adjust the left pointer if the distinct count exceeds MaxDistinct.
        {NewLeft, NewFreqMap2, NewDistinctCount2} = 
            adjust_left_pointer(Left, NewFreqMap1, NewDistinctCount1, Arr, N, MaxDistinct),

        %% All subarrays ending at Right and starting from NewLeft to Right are valid.
        NewTotalCount = TotalCount + (Right - NewLeft + 1),

        %% Move to the next right position.
        count_subarrays_loop(NewLeft, Right + 1, NewFreqMap2, NewDistinctCount2, NewTotalCount, Arr, N, MaxDistinct)
    end.

adjust_left_pointer(Left, FreqMap, DistinctCount, Arr, N, MaxDistinct) ->
    if DistinctCount > MaxDistinct ->
        %% If distinct count exceeds MaxDistinct, shrink the window from the left.
        NumL = array:get(Left, Arr),
        FreqL = maps:get(NumL, FreqMap),
        NewFreqMap = maps:put(NumL, FreqL - 1, FreqMap),
        NewDistinctCount = if FreqL - 1 == 0 -> DistinctCount - 1; true -> DistinctCount end,

        %% Recurse with the moved left pointer.
        adjust_left_pointer(Left + 1, NewFreqMap, NewDistinctCount, Arr, N, MaxDistinct);
    true ->
        %% Distinct count is within limits, return current state.
        {Left, FreqMap, DistinctCount}
    end.