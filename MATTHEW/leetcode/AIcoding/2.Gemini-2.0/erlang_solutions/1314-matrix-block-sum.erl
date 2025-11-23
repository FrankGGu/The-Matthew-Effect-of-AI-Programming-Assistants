-module(matrix_block_sum).
-export([matrix_block_sum/3]).

matrix_block_sum(Mat, K) ->
  Rows = length(Mat),
  Cols = length(hd(Mat)),
  Sum = lists:foldl(
    fun(Row, Acc) ->
      lists:foldl(
        fun(Col, Acc2) ->
          Acc2 ++ [{Row, Col, block_sum(Mat, Row, Col, K, Rows, Cols)}]
        end,
        Acc,
        lists:seq(0, Cols - 1)
      )
    end,
    [],
    lists:seq(0, Rows - 1)
  ),
  lists:foldl(
    fun({R, C, S}, Acc) ->
      lists:nth(R + 1, Acc) ! (C + 1, S),
      Acc
    end,
    create_matrix(Rows, Cols, 0),
    Sum
  ).

block_sum(Mat, Row, Col, K, Rows, Cols) ->
  RowStart = max(0, Row - K),
  RowEnd = min(Rows - 1, Row + K),
  ColStart = max(0, Col - K),
  ColEnd = min(Cols - 1, Col + K),
  sum_block(Mat, RowStart, RowEnd, ColStart, ColEnd).

sum_block(Mat, RowStart, RowEnd, ColStart, ColEnd) ->
  lists:foldl(
    fun(Row, Acc) ->
      lists:foldl(
        fun(Col, Acc2) ->
          Acc2 + lists:nth(Row + 1, Mat) ! (Col + 1)
        end,
        Acc,
        lists:seq(ColStart, ColEnd)
      )
    end,
    0,
    lists:seq(RowStart, RowEnd)
  ).

create_matrix(Rows, Cols, Value) ->
  lists:map(fun(_) -> create_row(Cols, Value) end, lists:seq(1, Rows)).

create_row(Cols, Value) ->
  lists:map(fun(_) -> Value end, lists:seq(1, Cols)).