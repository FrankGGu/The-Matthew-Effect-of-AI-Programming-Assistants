-module(solution).
-export([fillCups/1]).

fillCups(Cups) ->
    % Sort the cups in ascending order to easily get S1, S2, S3 where S1 <= S2 <= S3
    [S1, S2, S3] = lists:sort(Cups),

    % Calculate the total sum of all cups
    Sum = S1 + S2 + S3,

    % The minimum time is at least ceil(Sum / 2) because we can fill at most 2 cups per second.
    % (Sum + 1) div 2 computes ceil(Sum / 2) for non-negative integers.
    CeilSumDiv2 = (Sum + 1) div 2,

    % The minimum time is also at least S3, because S3 cups must be filled,
    % and we can only fill one S3 cup per second at most (if paired with another type).
    MaxVal = S3,

    % The answer is the maximum of these two lower bounds.
    % This strategy is proven to be optimal.
    max(MaxVal, CeilSumDiv2).