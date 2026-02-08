-module(solution).
-export([smallestDistancePair/2]).

smallestDistancePair(Nums, K) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    ArrayNums = array:from_list(SortedNums),

    Low = 0,
    High = array:get(N - 1, ArrayNums) - array:get(0, ArrayNums),

    BinarySearch = fun F(L, H, Ans) ->
        if L =< H ->
            Mid = L + (H - L) div 2,
            Count = count_pairs_le(Mid, ArrayNums, N),
            if Count >= K ->
                F(L, Mid - 1, Mid);
            true ->
                F(Mid + 1, H, Ans)
            end;
        true ->
            Ans
        end
    end,
    BinarySearch(Low, High, High).

count_pairs_le(D, ArrayNums, N) ->
    count_pairs_le_impl(D, ArrayNums, N, 0, 0, 0).

count_pairs_le_impl(_D, _ArrayNums, N, I, _J, Count) when I >= N ->
    Count;
count_pairs_le_impl(D, ArrayNums, N, I, J, Count) ->
    ElemI = array:get(I, ArrayNums),
    J1 = move_j_forward(D, ArrayNums, N, ElemI, J),

    AddedCount = J1 - 1 - I,

    count_pairs_le_impl(D, ArrayNums, N, I + 1, J1, Count + AddedCount).

move_j_forward(D, ArrayNums, N, ElemI, J_start) ->
    move_j_loop(D, ArrayNums, N, ElemI, J_start).

move_j_loop(D, ArrayNums, N, ElemI, CurrentJ) when CurrentJ >= N ->
    CurrentJ;
move_j_loop(D, ArrayNums, N, ElemI, CurrentJ) ->
    ElemJ = array:get(CurrentJ, ArrayNums),
    if ElemJ - ElemI =< D ->
        move_j_loop(D, ArrayNums, N, ElemI, CurrentJ + 1);
    true ->
        CurrentJ
    end.