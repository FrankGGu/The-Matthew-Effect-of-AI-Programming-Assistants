-module(solution).
-export([count_squares/1]).

min(A, B, C) ->
    min(A, min(B, C)).

count_squares(Matrix) ->
    M = length(Matrix),
    N = length(hd(Matrix)),
    count_squares_iter(Matrix, M, N, 0, lists:duplicate(N, 0), 0).

count_squares_iter(_Matrix, M, _N, M, _PrevDPRow, TotalSum) ->
    TotalSum;
count_squares_iter(Matrix, M, N, RowIndex, PrevDPRow, AccTotalSum) ->
    CurrentMatrixRow = lists:nth(RowIndex + 1, Matrix),
    {CurrentDPRow, RowSum} = calculate_current_dp_row(CurrentMatrixRow, N, RowIndex, PrevDPRow),
    count_squares_iter(Matrix, M, N, RowIndex + 1, CurrentDPRow, AccTotalSum + RowSum).

calculate_current_dp_row(CurrentMatrixRow, N, RowIndex, PrevDPRow) ->
    {_FinalPrevColDPVal, ReversedCurrentDPRow, RowSum} = lists:foldl(
        fun(ColIndex, {PrevColDPVal, CurrentDPRowAcc, AccRowSum}) ->
            MatrixVal = lists:nth(ColIndex + 1, CurrentMatrixRow),

            if MatrixVal == 1 ->
                Top = if RowIndex > 0 -> lists:nth(ColIndex + 1, PrevDPRow); true -> 0 end,
                Left = PrevColDPVal,
                TopLeft = if RowIndex > 0 and ColIndex > 0 -> lists:nth(ColIndex, PrevDPRow); true -> 0 end,

                DPVal_calculated = 1 + min(Top, Left, TopLeft),
                {DPVal_calculated, [DPVal_calculated | CurrentDPRowAcc], AccRowSum + DPVal_calculated};
            true ->
                {0, [0 | CurrentDPRowAcc], AccRowSum + 0}
            end
        end,
        {0, [], 0},
        lists:seq(0, N - 1)
    ),
    {lists:reverse(ReversedCurrentDPRow), RowSum}.