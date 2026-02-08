-module(lucky_numbers).
-export([lucky_numbers/1]).

lucky_numbers(Matrix) ->
  Rows = length(Matrix),
  Cols = length(lists:nth(1, Matrix)),
  RowMins = [lists:min(Row) || Row <- Matrix],
  ColMaxs = [
    lists:max([lists:nth(RowIndex, Row) || Row <- Matrix])
    || RowIndex <- lists:seq(1, Cols)
  ],
  [
    lists:nth(RowIndex, lists:nth(RowIndex2, Matrix))
    || RowIndex2 <- lists:seq(1, Rows),
    RowIndex <- lists:seq(1, Cols),
    lists:nth(RowIndex2, RowMins) == lists:nth(RowIndex, lists:nth(RowIndex2, Matrix)),
    lists:nth(RowIndex, ColMaxs) == lists:nth(RowIndex, lists:nth(RowIndex2, Matrix))
  ].