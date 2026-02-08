-module(snake_in_matrix).
-export([solve/1]).

solve(Matrix) ->
  {Rows, Cols} = get_matrix_dimensions(Matrix),
  solve_helper(Matrix, Rows, Cols, 0, 0, true, []).

solve_helper(_Matrix, _Rows, _Cols, Row, Col, _Right, Acc) when Row < 0; Row >= _Rows; Col < 0; Col >= _Cols ->
  lists:reverse(Acc);
solve_helper(Matrix, Rows, Cols, Row, Col, Right, Acc) ->
  Val = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
  solve_helper(Matrix, Rows, Cols, Row, get_next_col(Col, Right), not Right, [Val | Acc]).

get_matrix_dimensions(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  {Rows, Cols}.

get_next_col(Col, Right) ->
  case Right of
    true -> Col + 1;
    false -> Col - 1
  end.