-module(solution).
-export([countRangeSum/3]).

countRangeSum(Nums, Lower, Upper) ->
    % Build prefix sums: [0, P1, P2, ..., Pn]
    % This is done by folding, prepending to an accumulator list, and then reversing.
    % This ensures O(N) complexity for building the prefix sums list.
    PrefixSums = [0 | lists:reverse(lists:foldl(
        fun(X, {Acc, Sum}) -> {[Sum + X | Acc], Sum + X} end, {[], 0}, Nums
    ))],

    % Call the main recursive merge-sort-like function.
    % It returns {Count, SortedList}. We only need the Count.
    {Count, _SortedPrefixSums} = merge_sort_count_list(PrefixSums, Lower, Upper),
    Count.

merge_sort_count_list(List, _Lower, _Upper) when length(List) < 2 ->
    % Base case: A list with 0 or 1 element has no range sums to count within itself.
    % It is already sorted.
    {0, List};
merge_sort_count_list(List, Lower, Upper) ->
    Len = length(List),
    Mid = Len div 2,
    % Divide the list into two halves.
    {Left, Right} = lists:split(Mid, List),

    % Recursively process the left and right halves.
    {CountL, SortedLeft} = merge_sort_count_list(Left, Lower, Upper),
    {CountR, SortedRight} = merge_sort_count_list(Right, Lower, Upper),

    % Count cross-range sums between elements of SortedLeft and SortedRight.
    % This is the core counting step where Pj - Pi is calculated across the split point.
    CountM = count_cross_range_sums(SortedLeft, SortedRight, Lower, Upper),

    % Merge the two sorted halves to produce a single sorted list.
    SortedMerged = merge_sorted_lists(SortedLeft, SortedRight),

    % The total count is the sum of counts from left, right, and cross-parts.
    {CountL + CountR + CountM, SortedMerged}.

count_cross_range_sums(LeftList, RightList, Lower, Upper) ->
    RightArr = array:from_list(RightList),
    RightLen = array:size(RightArr),

    % Iterate through LeftList and accumulate counts.
    count_cross_sums_with_array(LeftList, RightArr, RightLen, Lower, Upper, 0).

count_cross_sums_with_array([], _RightArr, _RightLen, _Lower, _Upper, AccCount) ->
    AccCount;
count_cross_sums_with_array([L | Ls], RightArr, RightLen, Lower, Upper, AccCount) ->
    % For each L from LeftList, we need to find R from RightList such that:
    % L + Lower <= R <= L + Upper
    TargetLower = L + Lower,
    TargetUpper = L + Upper,

    % Find index K1 such that RightArr[K1] is the first element >= TargetLower.
    % This uses binary search.
    K1 = find_first_ge(RightArr, 0, RightLen - 1, TargetLower),
    % Find index K2 such that RightArr[K2] is the first element > TargetUpper.
    % This also uses binary search.
    K2 = find_first_gt(RightArr, 0, RightLen - 1, TargetUpper),

    % The number of elements R in RightArr that satisfy the condition for current L
    % is the count of elements between index K1 (inclusive) and K2 (exclusive).
    CountForL = K2 - K1,

    % Recursively process the rest of LeftList.
    count_cross_sums_with_array(Ls, RightArr, RightLen, Lower, Upper, AccCount + CountForL).

find_first_ge(Arr, Low, High, Val) ->
    Ans = High + 1, % Default result if no element satisfies the condition
    L = Low,
    R = High,
    find_first_ge_loop(Arr, L, R, Val, Ans).

find_first_ge_loop(_Arr, L, R, _Val, Ans) when L > R -> Ans;
find_first_ge_loop(Arr, L, R, Val, Ans) ->
    Mid = L + (R - L) div 2, % Calculate mid index
    MidVal = array:get(Mid, Arr), % Get value at mid
    if
        MidVal >= Val -> 
            % Current MidVal satisfies condition, store Mid as a potential answer,
            % and try to find an earlier (smaller index) one in the left half.
            find_first_ge_loop(Arr, L, Mid - 1, Val, Mid);
        true -> 
            % MidVal is too small, search in the right half.
            find_first_ge_loop(Arr, Mid + 1, R, Val, Ans)
    end.

find_first_gt(Arr, Low, High, Val) ->
    Ans = High + 1, % Default result if no element satisfies the condition
    L = Low,
    R = High,
    find_first_gt_loop(Arr, L, R, Val, Ans).

find_first_gt_loop(_Arr, L, R, _Val, Ans) when L > R -> Ans;
find_first_gt_loop(Arr, L, R, Val, Ans) ->
    Mid = L + (R - L) div 2, % Calculate mid index
    MidVal = array:get(Mid, Arr), % Get value at mid
    if
        MidVal > Val -> 
            % Current MidVal satisfies condition, store Mid as a potential answer,
            % and try to find an earlier (smaller index) one in the left half.
            find_first_gt_loop(Arr, L, Mid - 1, Val, Mid);
        true -> 
            % MidVal is not strictly greater, search in the right half.
            find_first_gt_loop(Arr, Mid + 1, R, Val, Ans)
    end.

merge_sorted_lists(A, []) -> A;
merge_sorted_lists([], B) -> B;
merge_sorted_lists([AH | AT] = A, [BH | BT] = B) ->
    if
        AH =< BH -> [AH | merge_sorted_lists(AT, B)];
        true -> [BH | merge_sorted_lists(A, BT)]
    end.