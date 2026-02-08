-module(toeplitz_matrix).
-export([is_toeplitz_matrix/1]).

is_toeplitz_matrix(Matrix) ->
  {Rows, Cols} = matrix_size(Matrix),

  lists:all(fun(Row) -> 
              lists:all(fun(Col) -> 
                          check_toeplitz(Matrix, Row, Col, Rows, Cols)
                        end, lists:seq(1, Cols))
            end, lists:seq(1, Rows)).

check_toeplitz(Matrix, Row, Col, Rows, Cols) ->
  if Row + 1 =< Rows andalso Col + 1 =< Cols then
    element(Row, Col, Matrix) == element(Row + 1, Col + 1, Matrix)
  else
    true
  end.

matrix_size(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  {Rows, Cols}.

element(Row, Col, Matrix) ->
  lists:nth(Col, lists:nth(Row, Matrix)).