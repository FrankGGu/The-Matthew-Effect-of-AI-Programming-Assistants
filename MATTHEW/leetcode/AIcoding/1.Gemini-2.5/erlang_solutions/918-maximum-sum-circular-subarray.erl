-module(solution).
-export([maxSubarraySumCircular/1]).

maxSubarraySumCircular(Nums) ->
    [H|_] = Nums, % Nums is guaranteed to have at least one element

    % Perform a single pass to calculate:
    % 1. MaxKadane: The maximum subarray sum (linear array, using Kadane's algorithm).
    % 2. MinKadane: The minimum subarray sum (linear array, using a modified Kadane's algorithm).
    % 3. TotalSum: The sum of all elements in the array.
    {MaxKadane, MinKadane, TotalSum} = kadane_pass(tl(Nums), H, H, H, H, H),

    if
        MaxKadane < 0 ->
            % If MaxKadane is negative, it means all numbers in the array are negative,
            % or the maximum sum found is a single negative number.
            % In this case, a circular subarray (wrapping around) would always result
            % in a sum less than or equal to the largest single negative number.
            % For example, if Nums = [-2, -3, -1], MaxKadane is -1.
            % TotalSum - MinKadane would be -6 - (-6) = 0, which is incorrect.
            % The correct answer is -1.
            MaxKadane;
        true ->
            % The maximum sum circular subarray is either:
            % 1. A non-wrapping subarray (MaxKadane).
            % 2. A wrapping subarray, which is equivalent to TotalSum - MinKadane.
            %    (The elements not included in the wrapping subarray form the minimum subarray sum).
            max(MaxKadane, TotalSum - MinKadane)
    end.

kadane_pass([], MaxSoFar, _CurrentMax, MinSoFar, _CurrentMin, TotalSum) ->
    {MaxSoFar, MinSoFar, TotalSum};
kadane_pass([H|T], MaxSoFar, CurrentMax, MinSoFar, CurrentMin, TotalSum) ->
    % Update CurrentMax for the maximum sum ending at H
    NewCurrentMax = max(H, H + CurrentMax),
    % Update MaxSoFar with the new overall maximum
    NewMaxSoFar = max(MaxSoFar, NewCurrentMax),

    % Update CurrentMin for the minimum sum ending at H
    NewCurrentMin = min(H, H + CurrentMin),
    % Update MinSoFar with the new overall minimum
    NewMinSoFar = min(MinSoFar, NewCurrentMin),

    % Update TotalSum
    NewTotalSum = TotalSum + H,

    % Recurse with updated values
    kadane_pass(T, NewMaxSoFar, NewCurrentMax, NewMinSoFar, NewCurrentMin, NewTotalSum).