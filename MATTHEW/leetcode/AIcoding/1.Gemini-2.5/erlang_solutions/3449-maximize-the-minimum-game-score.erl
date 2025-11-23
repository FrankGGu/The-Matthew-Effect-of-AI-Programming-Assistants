-module(solution).
-export([solve/2]).

can_split(TargetSum, Nums, K) ->
    can_split_recursive(TargetSum, Nums, K, 0, 0).

can_split_recursive(_TargetSum, [], K, _CurrentSum, SubarrayCount) ->
    % All numbers processed. Check if we have enough subarrays.
    SubarrayCount >= K.

can_split_recursive(TargetSum, [H|T], K, CurrentSum, SubarrayCount) ->
    NewCurrentSum = CurrentSum + H,
    if
        NewCurrentSum >= TargetSum ->
            % Current subarray sum meets the target.
            % Start a new subarray and increment count.
            can_split_recursive(TargetSum, T, K, 0, SubarrayCount + 1);
        true ->
            % Continue adding to the current subarray.
            can_split_recursive(TargetSum, T, K, NewCurrentSum, SubarrayCount)
    end.

solve(Nums, K) ->
    % The minimum possible value for the minimum sum is the smallest element in Nums.
    MinVal = lists:min(Nums),
    % The maximum possible value for the minimum sum is the total sum of Nums (if K=1).
    SumVal = lists:sum(Nums),

    % Binary search range for the potential minimum sum.
    Low = MinVal,
    High = SumVal,

    % Perform binary search. Initial answer is 0.
    binary_search(Low, High, Nums, K, 0).

binary_search(Low, High, Nums, K, Ans) when Low =< High ->
    Mid = Low + (High - Low) div 2, % Calculate midpoint to avoid overflow
    if
        can_split(Mid, Nums, K) ->
            % If it's possible to achieve Mid as the minimum sum,
            % try for a higher minimum sum. Store Mid as a potential answer.
            binary_search(Mid + 1, High, Nums, K, Mid);
        true ->
            % If Mid is too high to be the minimum sum,
            % reduce the upper bound.
            binary_search(Low, Mid - 1, Nums, K, Ans)
    end;
binary_search(_Low, _High, _Nums, _K, Ans) ->
    % Search range exhausted, return the best answer found.
    Ans.