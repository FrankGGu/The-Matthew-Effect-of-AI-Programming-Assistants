-module(count_submatrices).
-export([num_submatrices/2]).

num_submatrices(Mat, K) ->
  num_submatrices_helper(Mat, K, 0).

num_submatrices_helper(Mat, K, Acc) ->
  Rows = length(Mat),
  Cols = length(hd(Mat)),
  num_submatrices_inner(Mat, K, 1, 1, Rows, Cols, Acc).

num_submatrices_inner(_Mat, _K, Row, _Col, Rows, _Cols, Acc) when Row > Rows ->
  Acc;

num_submatrices_inner(Mat, K, Row, Col, Rows, Cols, Acc) when Col > Cols ->
  num_submatrices_inner(Mat, K, Row + 1, 1, Rows, Cols, Acc);

num_submatrices_inner(Mat, K, Row, Col, Rows, Cols, Acc) ->
  Count = count_valid_submatrices(Mat, K, Row, Col, Rows, Cols, 0),
  num_submatrices_inner(Mat, K, Row, Col + 1, Rows, Cols, Acc + Count).

count_valid_submatrices(Mat, K, RowStart, ColStart, Rows, Cols, Acc) ->
  count_valid_submatrices_inner(Mat, K, RowStart, ColStart, 1, 1, Rows, Cols, 0, Acc).

count_valid_submatrices_inner(Mat, K, RowStart, ColStart, RowEnd, ColEnd, Rows, Cols, Sum, Acc) when RowEnd > Rows orelse ColEnd > Cols ->
  Acc;

count_valid_submatrices_inner(Mat, K, RowStart, ColStart, RowEnd, ColEnd, Rows, Cols, Sum, Acc) ->
  NewSum = calculate_submatrix_sum(Mat, RowStart, ColStart, RowEnd, ColEnd),
  if
    NewSum < K ->
      count_valid_submatrices_inner(Mat, K, RowStart, ColStart, RowEnd, ColEnd + 1, Rows, Cols, Sum, Acc + 1);
    true ->
      Acc
  end.

calculate_submatrix_sum(Mat, RowStart, ColStart, RowEnd, ColEnd) ->
  calculate_submatrix_sum_helper(Mat, RowStart, ColStart, RowEnd, ColEnd, 0).

calculate_submatrix_sum_helper(Mat, RowStart, ColStart, RowEnd, ColEnd, Sum) ->
  Rows = RowEnd - RowStart + 1,
  Cols = ColEnd - ColStart + 1,

  calculate_sum(Mat, RowStart, ColStart, Rows, Cols).

calculate_sum(Mat, RowStart, ColStart, Rows, Cols) ->
  calculate_sum_inner(Mat, RowStart, ColStart, Rows, Cols, 0).

calculate_sum_inner(Mat, RowStart, ColStart, Rows, Cols, Acc) when Rows < 1 ->
  Acc;

calculate_sum_inner(Mat, RowStart, ColStart, Rows, Cols, Acc) ->
  calculate_row_sum(Mat, RowStart, ColStart, Cols, 0, RowSum),
  calculate_sum_inner(Mat, RowStart+1, ColStart, Rows-1, Cols, Acc + RowSum).

calculate_row_sum(_Mat, _RowStart, _ColStart, Cols, Acc, Acc) when Cols < 1 ->
    ok;
calculate_row_sum(Mat, RowStart, ColStart, Cols, Acc, Result) ->
  Value = lists:nth(ColStart-1, lists:nth(RowStart-1, Mat)),
  calculate_row_sum(Mat, RowStart, ColStart+1, Cols-1, Acc + Value, Result).