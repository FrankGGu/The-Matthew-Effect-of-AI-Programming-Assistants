-module(solution).
-export([find_unsorted_subarray/1]).

find_unsorted_subarray(Nums) ->
    Len = length(Nums),
    if Len =< 1 ->
        0;
    true ->
        SortedNums = lists:sort(Nums),

        Left = find_first_diff_from_start(Nums, SortedNums, 0),

        if Left == Len ->
            0;
        true ->
            RevNums = lists:reverse(Nums),
            RevSortedNums = lists:reverse(SortedNums),

            RightDiffFromEnd = find_first_diff_from_start(RevNums, RevSortedNums, 0),

            Right = Len - 1 - RightDiffFromEnd,

            Right - Left + 1
        end
    end.

find_first_diff_from_start(L1, L2, Index) ->
    case {L1, L2} of
        {[], []} -> Index;
        {[H1|_], [H2|_]} when H1 /= H2 -> Index;
        {[_|T1], [_|T2]} -> find_first_diff_from_start(T1, T2, Index + 1)
    end.