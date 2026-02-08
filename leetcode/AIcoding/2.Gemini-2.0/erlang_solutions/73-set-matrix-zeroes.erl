-module(set_matrix_zeroes).
-export([set_zeroes/1]).

set_zeroes(Matrix) ->
  {Rows, Cols} = get_dimensions(Matrix),
  {ZeroRows, ZeroCols} = find_zeroes(Matrix, Rows, Cols),
  set_zeroes_in_matrix(Matrix, ZeroRows, ZeroCols, Rows, Cols).

get_dimensions(Matrix) ->
  Rows = length(Matrix),
  Cols = length(lists:nth(1, Matrix)),
  {Rows, Cols}.

find_zeroes(Matrix, Rows, Cols) ->
  find_zeroes_helper(Matrix, Rows, Cols, 1, 1, [], []).

find_zeroes_helper(_, Rows, Cols, Row, Col, ZeroRows, ZeroCols) when Row > Rows ->
  {lists:usort(ZeroRows), lists:usort(ZeroCols)};
find_zeroes_helper(Matrix, Rows, Cols, Row, Col, ZeroRows, ZeroCols) ->
  Value = lists:nth(Col, lists:nth(Row, Matrix)),
  case Value of
    0 ->
      NewZeroRows = [Row | ZeroRows],
      NewZeroCols = [Col | ZeroCols],
      NextCol = Col + 1,
      NextRow = Row,
      if
        NextCol > Cols ->
          NextCol = 1,
          NextRow = Row + 1;
        true ->
          ok
      end,
      find_zeroes_helper(Matrix, Rows, Cols, NextRow, NextCol, NewZeroRows, NewZeroCols);
    _ ->
      NextCol = Col + 1,
      NextRow = Row,
      if
        NextCol > Cols ->
          NextCol = 1,
          NextRow = Row + 1;
        true ->
          ok
      end,
      find_zeroes_helper(Matrix, Rows, Cols, NextRow, NextCol, ZeroRows, ZeroCols)
  end.

set_zeroes_in_matrix(Matrix, ZeroRows, ZeroCols, Rows, Cols) ->
  set_zeroes_in_matrix_helper(Matrix, ZeroRows, ZeroCols, Rows, Cols, 1, []).

set_zeroes_in_matrix_helper(_, _, _, Rows, _, Row, Acc) when Row > Rows ->
  lists:reverse(Acc);
set_zeroes_in_matrix_helper(Matrix, ZeroRows, ZeroCols, Rows, Cols, Row, Acc) ->
  NewRow = set_row(lists:nth(Row, Matrix), ZeroCols, Cols, 1, []),
  NewMatrix = [NewRow | Acc],
  set_zeroes_in_matrix_helper(Matrix, ZeroRows, ZeroCols, Rows, Cols, Row + 1, NewMatrix).

set_row(Row, ZeroCols, Cols, Col, Acc) when Col > Cols ->
  lists:reverse(Acc);
set_row(Row, ZeroCols, Cols, Col, Acc) ->
  case lists:member(Col, ZeroCols) of
    true ->
      NewValue = 0,
      NewRow = [NewValue | Acc],
      set_row(Row, ZeroCols, Cols, Col + 1, NewRow);
    false ->
      Value = lists:nth(Col, Row),
      NewRow = [Value | Acc],
      set_row(Row, ZeroCols, Cols, Col + 1, NewRow)
  end.