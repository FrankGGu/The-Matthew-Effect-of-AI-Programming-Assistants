-module(solution).
-export([maximizeConsecutive/2]).

maximizeConsecutive(Nums, K) ->
    SortedNums = lists:sort(Nums),
    maximize_consecutive_impl(SortedNums, K).

maximize_consecutive_impl(Nums, K) ->
    N = length(Nums),
    if N == 0 ->
        0;
    true ->
        % Convert list to array for O(1) access to elements by index.
        % This is crucial for performance with large N.
        NumsArray = array:from_list(Nums),
        MaxLen = 0,
        Left = 0, % 0-indexed left pointer for the sliding window
        FreqMap = maps:new(), % Frequency map for elements in the current window [NumsArray[Left]...NumsArray[Right]]
        % Right is also 0-indexed
        maximize_consecutive_loop(NumsArray, N, K, Left, FreqMap, MaxLen, 0)
    end.

maximize_consecutive_loop(NumsArray, N, K, Left, FreqMap, MaxLen, Right) when Right < N ->
    CurrentNum = array:get(Right, NumsArray), % Get the current element at the right end of the window

    % Add CurrentNum to FreqMap
    NewFreqMap1 = maps:update_with(CurrentNum, fun(Val) -> Val + 1 end, 1, FreqMap),

    % Shrink window from the left if the cost condition is violated
    {NewLeft, UpdatedFreqMap} = shrink_window_loop(NumsArray, K, Left, NewFreqMap1, CurrentNum, Right),

    % After shrinking, the window [NumsArray[NewLeft]...NumsArray[Right]] is valid.
    % The number of distinct elements in this valid window is maps:size(UpdatedFreqMap).
    % We have K operations to change elements.
    % The maximum length of a consecutive sequence we can form is (number of distinct elements) + K.
    % This is because we can use the 'DistinctCount' unique numbers we have, and 'K' operations
    % to fill in any 'K' missing numbers to extend the sequence.
    CurrentCandidateLen = maps:size(UpdatedFreqMap) + K,
    NewMaxLen = max(MaxLen, CurrentCandidateLen),

    maximize_consecutive_loop(NumsArray, N, K, NewLeft, UpdatedFreqMap, NewMaxLen, Right + 1);

maximize_consecutive_loop(_NumsArray, _N, _K, _Left, _FreqMap, MaxLen, _Right) ->
    MaxLen.

shrink_window_loop(NumsArray, K, Left, FreqMap, CurrentRightNum, _RightIdx) ->
    % WindowMinVal is the value at the left end of the current window
    WindowMinVal = array:get(Left, NumsArray),

    % WindowRangeLen is the length of the value range covered by the window [WindowMinVal, CurrentRightNum]
    WindowRangeLen = CurrentRightNum - WindowMinVal + 1,

    % DistinctCount is the number of unique elements in the current window
    DistinctCount = maps:size(FreqMap),

    % The condition for shrinking:
    % We can form a consecutive sequence of length (DistinctCount + K).
    % This sequence must fit within the range defined by the window [WindowMinVal, CurrentRightNum].
    % If WindowRangeLen (the actual span of values) is greater than (DistinctCount + K) (the potential length),
    % it means the numbers in our window are too spread out, even with K operations, to form
    % a single consecutive sequence of length (DistinctCount + K) that includes both WindowMinVal and CurrentRightNum.
    % So, we must shrink the window from the left.
    if WindowRangeLen > DistinctCount + K ->
        LeftNum = array:get(Left, NumsArray),
        NewFreqMap = maps:update_with(LeftNum, fun(Val) -> Val - 1 end, FreqMap),
        UpdatedFreqMap = 
            case maps:get(LeftNum, NewFreqMap) of
                0 -> maps:remove(LeftNum, NewFreqMap);
                _ -> NewFreqMap
            end,

        % Recurse with incremented Left pointer
        shrink_window_loop(NumsArray, K, Left + 1, UpdatedFreqMap, CurrentRightNum, _RightIdx);
    true ->
        % WindowRangeLen <= DistinctCount + K, the window is valid
        % (i.e., the elements are close enough to form a sequence of length DistinctCount + K)
        {Left, FreqMap}
    end.