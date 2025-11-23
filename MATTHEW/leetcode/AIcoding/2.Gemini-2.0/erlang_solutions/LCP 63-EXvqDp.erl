-module(marble_game).
-export([solve/1]).

solve(board) ->
  {Rows, Cols} = get_dimensions(board),
  solve_helper(board, Rows, Cols).

solve_helper(Board, Rows, Cols) ->
  solve_helper(Board, Rows, Cols, 0, 0, []).

solve_helper(Board, Rows, Cols, Row, Col, Acc) ->
  if
    Row >= Rows ->
      lists:reverse(Acc);
    true ->
      case get_value(Board, Row, Col) of
        1 ->
          solve_helper(Board, Rows, Cols, next_col(Col, Rows, Cols, Row), next_row(Row, Cols), [ {Row, Col} | Acc]);
        0 ->
          solve_helper(Board, Rows, Cols, next_col(Col, Rows, Cols, Row), next_row(Row, Cols), Acc);
        _ ->
          solve_helper(Board, Rows, Cols, next_col(Col, Rows, Cols, Row), next_row(Row, Cols), Acc)
      end
  end.

next_row(Row, Cols) ->
  if
    Cols > 0 ->
      Row;
    true ->
      Row + 1
  end.

next_col(Col, Rows, Cols, Row) ->
  if
    Col < Cols - 1 ->
      Col + 1;
    true ->
      0
  end.

get_value(Board, Row, Col) ->
  try
    lists:nth(Row + 1, Board) of
      RowList ->
        lists:nth(Col + 1, RowList)
  catch
    _:_ ->
      -1
  end.

get_dimensions(Board) ->
  Rows = length(Board),
  Cols = case Board of
           [] -> 0;
           [FirstRow|_] -> length(FirstRow)
         end,
  {Rows, Cols}.