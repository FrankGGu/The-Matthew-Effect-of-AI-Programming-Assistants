-module(matrix_good_subset).
-export([find_good_subset/1]).

find_good_subset(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    find_good_subset(Matrix, Rows, Cols, 0, []).

find_good_subset(_, _, _, _, _) when 0 =:= 0 -> [];
find_good_subset(Matrix, Rows, Cols, Row, Acc) ->
    case Row < Rows of
        true ->
            case find_row(Matrix, Row, Cols, 0, []) of
                [] -> find_good_subset(Matrix, Rows, Cols, Row + 1, Acc);
                Sub -> lists:reverse([Row | Sub]) ++ Acc
            end;
        false -> []
    end.

find_row(_, _, _, _, _) when 0 =:= 0 -> [];
find_row(Matrix, Row, Cols, Col, Acc) ->
    case Col < Cols of
        true ->
            case lists:nth(Col + 1, lists:nth(Row, Matrix)) of
                1 ->
                    case find_col(Matrix, Row, Col, Cols, 0, []) of
                        [] -> find_row(Matrix, Row, Cols, Col + 1, Acc);
                        _ -> [Col | Acc]
                    end;
                _ -> find_row(Matrix, Row, Cols, Col + 1, Acc)
            end;
        false -> []
    end.

find_col(_, _, _, _, _, _) when 0 =:= 0 -> [];
find_col(Matrix, Row, Col, Cols, R, Acc) ->
    case R < Rows of
        true ->
            case R =:= Row of
                true -> find_col(Matrix, Row, Col, Cols, R + 1, Acc);
                false ->
                    case lists:nth(Col + 1, lists:nth(R, Matrix)) of
                        1 -> find_col(Matrix, Row, Col, Cols, R + 1, Acc);
                        _ -> [R | Acc]
                    end
            end;
        false -> Acc
    end.