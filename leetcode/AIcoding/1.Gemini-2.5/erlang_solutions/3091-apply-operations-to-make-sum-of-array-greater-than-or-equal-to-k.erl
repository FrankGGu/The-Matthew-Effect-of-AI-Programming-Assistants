-module(solution).
-export([minOperations/1]).

minOperations(K) ->
    if K == 1 ->
        0;
    true ->
        % Initialize MinOps with the strategy of only duplicating the initial '1'.
        % This means 0 increments (value 'v' remains 1), and K-1 duplicates.
        MinOps = K - 1,

        % The optimal value 'v' (the value of elements after increments, 1+x)
        % is expected to be around sqrt(K).
        % We iterate 'v' from 2 up to ceil(sqrt(K)) to find the minimum operations.
        % 'trunc(math:sqrt(K)) + 1' ensures we cover values around sqrt(K) including ceil(sqrt(K)).
        MaxVToConsider = trunc(math:sqrt(K)) + 1,

        % The value 'v' should not exceed K itself, as incrementing beyond K and then duplicating
        % would always be suboptimal compared to just incrementing to K (which takes K-1 ops).
        % So, the loop upper bound is min(K, MaxVToConsider).
        LoopUpperBound = min(K, MaxVToConsider),

        % Use a recursive helper function to iterate and find the minimum operations.
        % Start checking 'v' from 2, as 'v=1' case is handled by initial MinOps.
        calculate_min_ops(2, LoopUpperBound, K, MinOps)
    end.

calculate_min_ops(V, LoopUpperBound, K, CurrentMinOps) when V =< LoopUpperBound ->
    % Number of increments needed to transform the initial '1' into 'V'.
    NumIncrements = V - 1,

    % Number of duplicates needed to make the sum of 'V's greater than or equal to K.
    % We need (NumDuplicates + 1) * V >= K.
    % So, (NumDuplicates + 1) = ceil(K / V).
    % In Erlang, ceil(A/B) for positive integers A, B is (A + B - 1) div B.
    NumElements = (K + V - 1) div V,
    NumDuplicates = NumElements - 1,

    TotalOps = NumIncrements + NumDuplicates,

    NewMinOps = min(CurrentMinOps, TotalOps),

    calculate_min_ops(V + 1, LoopUpperBound, K, NewMinOps);

calculate_min_ops(_, _, _, CurrentMinOps) ->
    % Base case: Loop has finished, return the minimum found.
    CurrentMinOps.