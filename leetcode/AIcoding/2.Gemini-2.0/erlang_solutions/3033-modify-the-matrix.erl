-module(modify_the_matrix).
-export([solve/1]).

solve(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  Zeros = find_zeros(Matrix, Rows, Cols, []),
  fill_zeros(Matrix, Zeros, Rows, Cols).

find_zeros(Matrix, Rows, Cols, Acc) ->
  find_zeros(Matrix, Rows, Cols, 0, 0, Acc).

find_zeros(_Matrix, Rows, _Cols, Row, _Col, Acc) when Row >= Rows ->
  Acc;
find_zeros(Matrix, Rows, Cols, Row, Col, Acc) when Col >= Cols ->
  find_zeros(Matrix, Rows, Cols, Row + 1, 0, Acc);
find_zeros(Matrix, Rows, Cols, Row, Col, Acc) ->
  case lists:nth(Col + 1, lists:nth(Row + 1, Matrix)) of
    -1 ->
      find_zeros(Matrix, Rows, Cols, Row, Col + 1, [{Row, Col} | Acc]);
    _ ->
      find_zeros(Matrix, Rows, Cols, Row, Col + 1, Acc)
  end.

fill_zeros(Matrix, [], _Rows, _Cols) ->
  Matrix;
fill_zeros(Matrix, [{Row, Col} | T], Rows, Cols) ->
  MaxVal = find_max(Matrix, Rows, Cols),
  NewMatrix = replace_element(Matrix, Row, Col, MaxVal + 1),
  fill_zeros(NewMatrix, T, Rows, Cols).

find_max(Matrix, Rows, Cols) ->
  find_max(Matrix, Rows, Cols, 0, 0, -infinity).

find_max(_Matrix, Rows, _Cols, Row, _Col, Max) when Row >= Rows ->
  Max;
find_max(Matrix, Rows, Cols, Row, Col, Max) when Col >= Cols ->
  find_max(Matrix, Rows, Cols, Row + 1, 0, Max);
find_max(Matrix, Rows, Cols, Row, Col, Max) ->
  Val = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
  NewMax = max(Max, Val),
  find_max(Matrix, Rows, Cols, Row, Col + 1, NewMax).

replace_element(Matrix, Row, Col, Val) ->
  lists:map(fun(R, I) ->
              case I of
                Row + 1 ->
                  replace_in_row(R, Col, Val);
                _ ->
                  R
              end
            end,
            Matrix, lists:seq(1, length(Matrix))).

replace_in_row(Row, Col, Val) ->
  lists:map(fun(C, I) ->
              case I of
                Col + 1 ->
                  Val;
                _ ->
                  C
              end
            end,
            Row, lists:seq(1, length(Row))).