-module(solution).
-export([min_operations/2]).

min_operations(Nums, X) ->
    TotalSum = lists:sum(Nums),
    N = length(Nums),
    Target = TotalSum - X,

    % If the target sum for the middle subarray is negative,
    % it means X is greater than TotalSum, so it's impossible to reduce X to 0.
    % If the target sum is 0, it means we need to remove all elements,
    % so the answer is N (length of the array).
    if
        Target < 0 ->
            -1;
        Target == 0 ->
            N;
        true ->
            % Convert list to array for O(1) indexed access, which is crucial for
            % the efficiency of the sliding window algorithm.
            Arr = array:from_list(Nums),

            % Find the longest subarray within 'Nums' whose sum is 'Target'.
            % The state for the sliding window is:
            % (Array, TargetSum, LeftIdx, RightIdx, CurrentWindowSum, MaxLengthFound, TotalLength)
            % LeftIdx: The starting index of the current window.
            % RightIdx: The index of the element to be added next to the window (or current element being processed).
            % CurrentWindowSum: The sum of elements in the window [LeftIdx ... RightIdx-1].
            % MaxLengthFound: The maximum length of a subarray found so far that sums to TargetSum.
            MaxLenFound = sliding_window(Arr, Target, 0, 0, 0, -1, N),

            % If MaxLenFound is -1, it means no subarray with the target sum was found.
            % Otherwise, the minimum operations is N minus the length of the longest such subarray.
            if
                MaxLenFound == -1 ->
                    -1;
                true ->
                    N - MaxLenFound
            end
    end.

sliding_window(Arr, Target, LeftIdx, RightIdx, CurrentWindowSum, MaxLen, N) ->
    % Base case: RightIdx has reached the end of the array, all elements processed.
    if RightIdx == N ->
        MaxLen;
    true ->
        % Expand window to the right by adding Arr[RightIdx].
        ValRight = array:get(RightIdx, Arr),
        NewCurrentWindowSum = CurrentWindowSum + ValRight,
        NewLeftIdx = LeftIdx,

        % Shrink window from the left if CurrentWindowSum exceeds Target.
        % The shrink_window function returns {FinalCurrentWindowSum, FinalLeftIdx}.
        {FinalCurrentWindowSum, FinalLeftIdx} = shrink_window(Arr, Target, NewCurrentWindowSum, NewLeftIdx, RightIdx),

        % Update MaxLen if the current window sum equals Target.
        % The length of the current window is (RightIdx - FinalLeftIdx + 1).
        NewMaxLen = if
            FinalCurrentWindowSum == Target ->
                max(MaxLen, RightIdx - FinalLeftIdx + 1);
            true ->
                MaxLen
        end,

        % Recurse for the next RightIdx (move the right boundary one step further).
        sliding_window(Arr, Target, FinalLeftIdx, RightIdx + 1, FinalCurrentWindowSum, NewMaxLen, N)
    end.

shrink_window(Arr, Target, CurrentWindowSum, LeftIdx, RightIdx) ->
    % Shrink as long as CurrentWindowSum is greater than Target and the window is valid (LeftIdx <= RightIdx).
    if
        CurrentWindowSum > Target andalso LeftIdx <= RightIdx ->
            ValLeft = array:get(LeftIdx, Arr),
            shrink_window(Arr, Target, CurrentWindowSum - ValLeft, LeftIdx + 1, RightIdx);
        true ->
            % Return the final sum and left index when shrinking stops.
            {CurrentWindowSum, LeftIdx}
    end.