-module(solution).
-export([min_sum_diff/1]).

min_sum_diff(Nums) ->
    N = length(Nums) div 2,
    TotalSum = lists:sum(Nums),
    {Nums1, Nums2} = lists:split(N, Nums),

    %% Generate all possible subset sums for Nums1, grouped by count of elements.
    %% Sums1Arr will be an array where Sums1Arr[K] is an ordset (sorted list) of sums
    %% of subsets of size K from Nums1.
    Sums1Arr = generate_sums(Nums1, N),

    %% Generate all possible subset sums for Nums2, grouped by count of elements.
    Sums2Arr = generate_sums(Nums2, N),

    %% Calculate the minimum sum difference.
    calculate_min_diff(N, TotalSum, Sums1Arr, Sums2Arr).

generate_sums(Arr, MaxCount) ->
    %% Initialize an array of ordsets (empty lists) for counts from 0 to MaxCount.
    InitialSumsByCount = array:from_list([ordsets:new() || _ <- lists:seq(0, MaxCount)]),
    generate_sums_helper(Arr, 0, 0, InitialSumsByCount).

generate_sums_helper([], CurrentSum, Count, Acc) ->
    %% Base case: No more elements to process. Add CurrentSum to the ordset for its Count.
    array:set(Count, ordsets:add_element(CurrentSum, array:get(Count, Acc)), Acc);
generate_sums_helper([H|T], CurrentSum, Count, Acc) ->
    %% Recursive step: Explore two options for the current element H.
    %% Option 1: Include H in the subset.
    AccWithH = generate_sums_helper(T, CurrentSum + H, Count + 1, Acc),
    %% Option 2: Exclude H from the subset.
    generate_sums_helper(T, CurrentSum, Count, AccWithH).

calculate_min_diff(N, TotalSum, Sums1Arr, Sums2Arr) ->
    %% Initialize MinDiff with a value that is guaranteed to be larger than any possible difference.
    %% abs(TotalSum) is a safe upper bound.
    MinDiff = abs(TotalSum),

    %% Iterate through all possible counts K (0 to N) for elements from Nums1.
    %% If K elements are taken from Nums1, then N-K elements must be taken from Nums2.
    lists:foldl(
        fun(K, CurrentMinDiff) ->
            Sums1K = array:get(K, Sums1Arr),
            Sums2NK = array:get(N - K, Sums2Arr),
            find_min_diff_for_k(Sums1K, Sums2NK, TotalSum, CurrentMinDiff)
        end, MinDiff, lists:seq(0, N)
    ).

find_min_diff_for_k(Sums1K, Sums2NK, TotalSum, CurrentMinDiff) ->
    %% We want to find S1 in Sums1K and S2 in Sums2NK such that abs((S1+S2) - (TotalSum - (S1+S2))) is minimized.
    %% This simplifies to minimizing abs(2 * (S1+S2) - TotalSum).
    %% This is equivalent to finding S1+S2 closest to TotalSum / 2.
    TargetSum = TotalSum div 2,

    %% Use a two-pointer approach since both Sums1K and Sums2NK are sorted.
    %% Sums1K is sorted ascending. Sums2NK is sorted ascending, so reverse it for descending.
    find_min_diff_two_pointers(Sums1K, lists:reverse(Sums2NK), TargetSum, TotalSum, CurrentMinDiff).

find_min_diff_two_pointers(L1, L2, TargetSum, TotalSum, CurrentMinDiff) ->
    case {L1, L2} of
        {[], _} -> CurrentMinDiff; %% One list is exhausted.
        {_, []} -> CurrentMinDiff; %% One list is exhausted.
        {[S1|_], [S2|_]} ->
            CurrentCombinedSum = S1 + S2,
            Diff = abs(2 * CurrentCombinedSum - TotalSum),
            NewMinDiff = min(CurrentMinDiff, Diff),

            %% Adjust pointers based on CurrentCombinedSum relative to TargetSum.
            if CurrentCombinedSum < TargetSum ->
                %% Sum is too small, need a larger S1. Move L1 pointer forward.
                find_min_diff_two_pointers(tl(L1), L2, TargetSum, TotalSum, NewMinDiff);
            else %% CurrentCombinedSum >= TargetSum
                %% Sum is too large or just right, need a smaller S2. Move L2 pointer forward (which is actually backward in the original ascending list).
                find_min_diff_two_pointers(L1, tl(L2), TargetSum, TotalSum, NewMinDiff)
            end
    end.