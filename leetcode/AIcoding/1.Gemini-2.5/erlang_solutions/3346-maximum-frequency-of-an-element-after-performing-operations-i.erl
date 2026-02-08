-module(solution).
-export([max_frequency/2]).

max_frequency(Nums, K) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),

    % Convert to array for O(1) access
    NumArray = array:from_list(SortedNums),

    % L: left pointer (index)
    % R: right pointer (index)
    % CurrentSum: sum of elements in the current window [L...R-1] (before adding NumR)
    % MaxFreq: maximum frequency found so far
    % N: total number of elements
    % K: max operations
    max_frequency_sliding_window(NumArray, K, 0, 0, 0, 0, N).

max_frequency_sliding_window(NumArray, K, L, R, CurrentSum, MaxFreq, N) when R < N ->
    % Get the element at R
    NumR = array:get(R, NumArray),

    NewCurrentSum = CurrentSum + NumR,

    % Shrink the window from the left if the cost exceeds K
    % The cost for window [L...R] to make all elements equal to NumR is
    % (R - L + 1) * NumR - NewCurrentSum
    {UpdatedL, UpdatedCurrentSum} = shrink_window(NumArray, K, L, R, NewCurrentSum, NumR),

    % The current window [UpdatedL...R] is valid. Its frequency is R - UpdatedL + 1.
    NewMaxFreq = max(MaxFreq, R - UpdatedL + 1),

    % Move the right pointer to the next element
    max_frequency_sliding_window(NumArray, K, UpdatedL, R + 1, UpdatedCurrentSum, NewMaxFreq, N);
max_frequency_sliding_window(_NumArray, _K, _L, _R, _CurrentSum, MaxFreq, _N) ->
    MaxFreq.

shrink_window(NumArray, K, CurrentL, R, CurrentSum, NumR) ->
    WindowSize = R - CurrentL + 1,
    Cost = WindowSize * NumR - CurrentSum,

    if Cost > K ->
        % If cost is too high, remove the leftmost element and shrink
        NumL = array:get(CurrentL, NumArray),
        shrink_window(NumArray, K, CurrentL + 1, R, CurrentSum - NumL, NumR);
    true ->
        % Window is valid, return current L and sum
        {CurrentL, CurrentSum}
    end.