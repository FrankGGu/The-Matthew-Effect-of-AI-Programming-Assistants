-module(solution).
-export([min_sum_sq_diff/4]).

min_sum_sq_diff(Nums1, Nums2, K1, K2) ->
    MaxDiff = 100000,
    Counts = array:new({MaxDiff + 1, 0}), % Initialize array of size MaxDiff+1 with zeros

    % Calculate initial differences and populate counts
    % Use lists:zip to iterate over Nums1 and Nums2 simultaneously
    ZippedNums = lists:zip(Nums1, Nums2),
    InitialCounts = lists:foldl(
        fun({N1, N2}, AccCounts) ->
            Diff = abs(N1 - N2),
            CurrentCount = array:get(Diff, AccCounts),
            array:set(Diff, CurrentCount + 1, AccCounts)
        end,
        Counts,
        ZippedNums
    ),

    KTotal = K1 + K2,

    % Apply operations to reduce differences
    FinalCounts = reduce_diffs(MaxDiff, InitialCounts, KTotal),

    % Calculate final sum of squared differences
    calculate_sum_sq_diff(MaxDiff, FinalCounts).

reduce_diffs(MaxDiff, Counts, K) ->
    reduce_diffs_loop(MaxDiff, Counts, K).

reduce_diffs_loop(D, Counts, 0) when D >= 0 ->
    Counts;
reduce_diffs_loop(D, Counts, K) when D < 1 -> % No more differences to reduce (all are 0)
    Counts;
reduce_diffs_loop(D, Counts, K) ->
    NumAtD = array:get(D, Counts),
    if
        NumAtD == 0 ->
            % No differences of value D, move to the next smaller difference
            reduce_diffs_loop(D - 1, Counts, K);
        K >= NumAtD ->
            % Enough operations to reduce all NumAtD differences from D to D-1
            NewCounts1 = array:set(D, 0, Counts), % Set count for D to 0
            CurrentCountAtDMinus1 = array:get(D - 1, NewCounts1),
            NewCounts2 = array:set(D - 1, CurrentCountAtDMinus1 + NumAtD, NewCounts1), % Add to D-1
            reduce_diffs_loop(D - 1, NewCounts2, K - NumAtD);
        true ->
            % K is not enough to reduce all NumAtD differences
            % Reduce K differences from D to D-1, then stop
            NewCounts1 = array:set(D, NumAtD - K, Counts), % Remaining at D
            CurrentCountAtDMinus1 = array:get(D - 1, NewCounts1),
            NewCounts2 = array:set(D - 1, CurrentCountAtDMinus1 + K, NewCounts1), % Add to D-1
            NewCounts2 % K becomes 0, so we return the final counts
    end.

calculate_sum_sq_diff(MaxDiff, Counts) ->
    calculate_sum_sq_diff_loop(0, MaxDiff, Counts, 0).

calculate_sum_sq_diff_loop(D, MaxDiff, Counts, AccSum) when D > MaxDiff ->
    AccSum;
calculate_sum_sq_diff_loop(D, MaxDiff, Counts, AccSum) ->
    NumAtD = array:get(D, Counts),
    Term = NumAtD * D * D,
    calculate_sum_sq_diff_loop(D + 1, MaxDiff, Counts, AccSum + Term).