-module(diagonal_traverse).
-export([find_diagonal_order/1]).

find_diagonal_order(Matrix) ->
  Rows = length(Matrix),
  Cols = case Rows > 0 of
           true -> length(lists:nth(1, Matrix));
           false -> 0
         end,
  find_diagonal_order_helper(Matrix, Rows, Cols, 0, 0, [], true).

find_diagonal_order_helper(_Matrix, _Rows, _Cols, _Row, _Col, Acc, _Up) when length(Acc) >= _Rows * _Cols ->
  lists:reverse(Acc);

find_diagonal_order_helper(Matrix, Rows, Cols, Row, Col, Acc, Up) ->
  case Up of
    true ->
      NewAcc = [lists:nth(Col + 1, lists:nth(Row + 1, Matrix)) | Acc],
      case Row - 1 < 0 of
        true ->
          case Col + 1 >= Cols of
            true ->
              find_diagonal_order_helper(Matrix, Rows, Cols, Row + 1, Col, NewAcc, false);
            false ->
              find_diagonal_order_helper(Matrix, Rows, Cols, Row, Col + 1, NewAcc, false)
          end;
        false ->
          case Col + 1 >= Cols of
            true ->
              find_diagonal_order_helper(Matrix, Rows, Cols, Row - 1, Col, NewAcc, false);
            false ->
              find_diagonal_order_helper(Matrix, Rows, Cols, Row - 1, Col + 1, NewAcc, true)
          end
      end;
    false ->
      NewAcc = [lists:nth(Col + 1, lists:nth(Row + 1, Matrix)) | Acc],
      case Col - 1 < 0 of
        true ->
          case Row + 1 >= Rows of
            true ->
              find_diagonal_order_helper(Matrix, Rows, Cols, Row, Col + 1, NewAcc, true);
            false ->
              find_diagonal_order_helper(Matrix, Rows, Cols, Row + 1, Col, NewAcc, true)
          end;
        false ->
          case Row + 1 >= Rows of
            true ->
              find_diagonal_order_helper(Matrix, Rows, Cols, Row, Col - 1, NewAcc, true);
            false ->
              find_diagonal_order_helper(Matrix, Rows, Cols, Row + 1, Col - 1, NewAcc, false)
          end
      end
  end.