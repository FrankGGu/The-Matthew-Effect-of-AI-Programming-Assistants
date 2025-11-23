-module(solution).
-export([max_product/1]).

max_product(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    max_product_helper(Matrix, 0, 0, Rows, Cols).

max_product_helper(Matrix, Row, Col, Rows, Cols) ->
    case Row >= Rows orelse Col >= Cols of
        true -> 1;
        false ->
            Cell = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
            case Cell of
                0 -> 0;
                _ ->
                    Down = max_product_helper(Matrix, Row + 1, Col, Rows, Cols),
                    Right = max_product_helper(Matrix, Row, Col + 1, Rows, Cols),
                    if
                        Down =:= 0 orelse Right =:= 0 -> 0;
                        true -> (Cell * max(Down, Right)) rem (10^9 + 7)
                    end
            end
    end.

max(A, B) when A > B -> A;
max(_, B) -> B.