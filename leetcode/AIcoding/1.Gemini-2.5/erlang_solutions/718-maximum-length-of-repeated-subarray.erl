-module(solution).
-export([find_length/2]).

find_length(Nums1, Nums2) ->
    M = length(Nums2),
    InitialPrevRow = lists:duplicate(M + 1, 0),
    solve_dp(Nums1, Nums2, 0, InitialPrevRow).

solve_dp([N1_head | N1_rest], Nums2_full, CurrentMax, PrevRow) ->
    {MaxInRow, CurrentRow} = solve_row(N1_head, Nums2_full, PrevRow, [], 0),
    solve_dp(N1_rest, Nums2_full, max(CurrentMax, MaxInRow), CurrentRow);
solve_dp([], _Nums2_full, CurrentMax, _PrevRow) ->
    CurrentMax.

solve_row(N1_val, [N2_head | N2_rest], [Prev_head | Prev_rest], CurrentRowAcc, MaxInRowAcc) ->
    NewVal = case N1_val == N2_head of
        true -> Prev_head + 1;
        false -> 0
    end,
    solve_row(N1_val, N2_rest, Prev_rest, [NewVal | CurrentRowAcc], max(MaxInRowAcc, NewVal));
solve_row(_N1_val, [], [], CurrentRowAcc, MaxInRowAcc) ->
    {MaxInRowAcc, [0 | lists:reverse(CurrentRowAcc)]}.