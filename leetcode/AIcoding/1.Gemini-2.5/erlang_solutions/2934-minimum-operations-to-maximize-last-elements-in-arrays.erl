-module(solution).
-export([min_operations_to_maximize_last_elements_in_arrays/2]).

check_and_count_swaps(Arr1, Arr2, Target1, Target2) ->
    N = length(Arr1),
    % Start recursion for elements from index 0 up to N-2.
    % N-1 is the index of the last element.
    check_and_count_swaps_recursive(Arr1, Arr2, Target1, Target2, 0, N - 1, 0).

check_and_count_swaps_recursive(_, _, _, _, CurrentIdx, NMinus1, AccSwaps) when CurrentIdx == NMinus1 ->
    % Base case: All elements up to N-2 have been processed.
    % Or, if N=1, NMinus1=0 and CurrentIdx=0, this means no elements to check.
    AccSwaps;
check_and_count_swaps_recursive([H1|T1], [H2|T2], Target1, Target2, CurrentIdx, NMinus1, AccSwaps) ->
    % Check if keeping (H1, H2) in their current positions satisfies conditions
    CanKeep = (H1 =< Target1 andalso H2 =< Target2),
    % Check if swapping (H1, H2) satisfies conditions
    CanSwap = (H2 =< Target1 andalso H1 =< Target2),

    if
        CanKeep andalso CanSwap ->
            % Both keeping and swapping satisfy the conditions.
            % To minimize operations, we choose to keep (0 swaps for this index).
            check_and_count_swaps_recursive(T1, T2, Target1, Target2, CurrentIdx + 1, NMinus1, AccSwaps);
        CanKeep ->
            % Only keeping satisfies the conditions (0 swaps for this index).
            check_and_count_swaps_recursive(T1, T2, Target1, Target2, CurrentIdx + 1, NMinus1, AccSwaps);
        CanSwap ->
            % Only swapping satisfies the conditions (1 swap for this index).
            check_and_count_swaps_recursive(T1, T2, Target1, Target2, CurrentIdx + 1, NMinus1, AccSwaps + 1);
        true ->
            % Neither keeping nor swapping satisfies the conditions.
            % This scenario is impossible.
            infinity
    end.

min_operations_to_maximize_last_elements_in_arrays(Nums1, Nums2) ->
    N = length(Nums1),

    % Get the original last elements.
    Last1_orig = lists:nth(N, Nums1),
    Last2_orig = lists:nth(N, Nums2),

    % Scenario 1: The last elements are NOT swapped.
    % The target values for the last elements remain (Last1_orig, Last2_orig).
    % No additional operation cost for the last elements themselves.
    Res1 = check_and_count_swaps(Nums1, Nums2, Last1_orig, Last2_orig),

    % Scenario 2: The last elements ARE swapped.
    % The target values for the last elements become (Last2_orig, Last1_orig).
    % This incurs 1 operation cost for the last elements themselves.
    Res2_base = check_and_count_swaps(Nums1, Nums2, Last2_orig, Last1_orig),
    Res2 = if Res2_base == infinity -> infinity;
             true -> 1 + Res2_base
           end,

    % The minimum operations is the minimum of the two scenarios.
    MinRes = min(Res1, Res2),

    % If no scenario is possible, return -1. Otherwise, return the minimum.
    if MinRes == infinity -> -1;
       true -> MinRes
    end.