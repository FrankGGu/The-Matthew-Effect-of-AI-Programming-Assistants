-module(matrix_block_sum).
-export([mat_sum/2]).

mat_sum(Mat, K) ->
    Rows = length(Mat),
    Cols = length(hd(Mat)),
    Acc = array:new({size, Rows}, {default, 0}),
    build_prefix(Acc, Mat, 0, 0, Rows, Cols),
    compute_block_sum(Mat, K, Rows, Cols, Acc).

build_prefix(Acc, Mat, I, J, Rows, Cols) when I < Rows ->
    build_prefix_row(Acc, Mat, I, J, Rows, Cols);
build_prefix(Acc, _Mat, _I, _J, _Rows, _Cols) ->
    Acc.

build_prefix_row(Acc, Mat, I, J, Rows, Cols) when J < Cols ->
    Val = lists:nth(J+1, lists:nth(I, Mat)),
    PrevRow = if I > 0 -> array:get(I-1, Acc); true -> 0 end,
    PrevCol = if J > 0 -> array:get(I, Acc, J-1); true -> 0 end,
    Diag = if I > 0 andalso J > 0 -> array:get(I-1, Acc, J-1); true -> 0 end,
    Current = Val + PrevRow + PrevCol - Diag,
    NewAcc = array:set(I, J, Current, Acc),
    build_prefix_row(NewAcc, Mat, I, J+1, Rows, Cols);
build_prefix_row(Acc, Mat, I, J, Rows, Cols) ->
    build_prefix(Acc, Mat, I+1, 0, Rows, Cols).

compute_block_sum(Mat, K, Rows, Cols, Acc) ->
    Result = array:new({size, Rows}, {default, 0}),
    compute_block_sum(Result, Mat, 0, 0, Rows, Cols, K, Acc).

compute_block_sum(Result, _Mat, I, J, Rows, Cols, _K, _Acc) when I >= Rows ->
    Result;
compute_block_sum(Result, _Mat, I, J, Rows, Cols, K, Acc) when J >= Cols ->
    compute_block_sum(Result, _Mat, I+1, 0, Rows, Cols, K, Acc);
compute_block_sum(Result, Mat, I, J, Rows, Cols, K, Acc) ->
    RowMin = max(0, I - K),
    RowMax = min(Rows - 1, I + K),
    ColMin = max(0, J - K),
    ColMax = min(Cols - 1, J + K),
    Sum = get_value(Acc, RowMax, ColMax) - get_value(Acc, RowMin - 1, ColMax) - get_value(Acc, RowMax, ColMin - 1) + get_value(Acc, RowMin - 1, ColMin - 1),
    NewResult = array:set(I, J, Sum, Result),
    compute_block_sum(NewResult, Mat, I, J+1, Rows, Cols, K, Acc).

get_value(Acc, I, J) when I < 0 orelse J < 0 ->
    0;
get_value(Acc, I, J) ->
    array:get(I, Acc, J).