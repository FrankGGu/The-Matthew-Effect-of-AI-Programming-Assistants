-module(solution).
-export([numberOfPairs/3]).

-spec numberOfPairs(Nums1 :: [integer()], Nums2 :: [integer()], Diff :: integer()) -> integer().
numberOfPairs(Nums1, Nums2, Diff) ->
    % Create the auxiliary array arr[k] = nums1[k] - nums2[k]
    Arr = lists:zipwith(fun(X, Y) -> X - Y end, Nums1, Nums2),

    % Use a modified merge sort to count pairs
    % The merge_sort function will return {Count, SortedList}
    {Count, _SortedArr} = merge_sort(Arr, Diff),
    Count.

merge_sort([], _Diff) -> {0, []};
merge_sort([X], _Diff) -> {0, [X]};
merge_sort(List, Diff) ->
    Len = length(List),
    Mid = Len div 2,
    {Left, Right} = lists:split(Mid, List),

    {CountL, SortedL} = merge_sort(Left, Diff),
    {CountR, SortedR} = merge_sort(Right, Diff),

    % Count pairs (i, j) where i is in Left and j is in Right
    % such that Arr[i] - Arr[j] <= Diff, or Arr[j] >= Arr[i] - Diff
    CrossCount = count_cross_pairs(SortedL, SortedR, Diff, length(SortedR)),

    % Merge the two sorted lists
    MergedList = merge(SortedL, SortedR),

    {CountL + CountR + CrossCount, MergedList}.

count_cross_pairs(L, R, Diff, R_len) ->
    count_cross_pairs_impl(L, R, Diff, R_len, 0).

count_cross_pairs_impl([], _R_ptr, _Diff, _R_ptr_len, Acc) -> Acc;
count_cross_pairs_impl([L_head | L_tail], R_ptr, Diff, R_ptr_len, Acc) ->
    Target = L_head - Diff,

    % Advance R_ptr and get the number of skipped elements.
    % SkippedCount is the number of elements in R_ptr that are < Target.
    {NewR_ptr, SkippedCount} = advance_r_pointer_with_skipped_count(R_ptr, Target, 0),

    % CountForLHead is the number of elements in NewR_ptr (which are >= Target).
    CountForLHead = R_ptr_len - SkippedCount,

    % The R_ptr_len for the next recursive call should be the length of NewR_ptr.
    count_cross_pairs_impl(L_tail, NewR_ptr, Diff, CountForLHead, Acc + CountForLHead).

advance_r_pointer_with_skipped_count([], _Target, CurrentSkipped) -> {[], CurrentSkipped};
advance_r_pointer_with_skipped_count([R_head | R_tail] = R_list, Target, CurrentSkipped) ->
    if R_head < Target ->
        advance_r_pointer_with_skipped_count(R_tail, Target, CurrentSkipped + 1);
    true ->
        {R_list, CurrentSkipped}
    end.

merge([], L2) -> L2;
merge(L1, []) -> L1;
merge([H1 | T1] = L1, [H2 | T2] = L2) ->
    if H1 =< H2 ->
        [H1 | merge(T1, L2)];
    true ->
        [H2 | merge(L1, T2)]
    end.