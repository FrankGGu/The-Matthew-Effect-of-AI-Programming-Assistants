-module(row_with_maximum_ones).
-export([row_and_maximum_ones/1]).

row_and_maximum_ones(Mat) ->
  row_and_maximum_ones(Mat, 0, 0, -1, 0).

row_and_maximum_ones([], MaxRow, MaxOnes, RowIdx, _) ->
  [RowIdx, MaxOnes];
row_and_maximum_ones([Row|Rest], MaxRow, MaxOnes, RowIdx, CurrentRow) ->
  Ones = lists:sum([I || I <- Row, I == 1]),
  case Ones > MaxOnes of
    true ->
      row_and_maximum_ones(Rest, Ones, Ones, CurrentRow, CurrentRow + 1);
    false ->
      row_and_maximum_ones(Rest, MaxRow, MaxOnes, RowIdx, CurrentRow + 1)
  end.