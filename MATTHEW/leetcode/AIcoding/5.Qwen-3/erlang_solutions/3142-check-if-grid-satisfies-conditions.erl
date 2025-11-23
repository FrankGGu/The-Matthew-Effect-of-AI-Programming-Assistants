-module(solution).
-export([solve/1]).

solve(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    check_rows(Grid, Rows, Cols),
    check_cols(Grid, Rows, Cols),
    true.

check_rows([], _, _) -> true;
check_rows([Row | Rest], Rows, Cols) ->
    case is_valid_row(Row, Cols) of
        true -> check_rows(Rest, Rows, Cols);
        false -> false
    end.

is_valid_row([], _) -> true;
is_valid_row([H | T], Cols) ->
    case H of
        0 -> is_valid_row(T, Cols);
        1 -> 
            case T of
                [] -> true;
                [Next | _] when Next == 0 -> is_valid_row(T, Cols);
                _ -> false
            end;
        _ -> false
    end.

check_cols([], _, _) -> true;
check_cols([_ | Rest], Rows, Cols) ->
    check_cols_col(0, Rest, Rows, Cols).

check_cols_col(_, [], _, _) -> true;
check_cols_col(Col, [Row | Rest], Rows, Cols) ->
    case element(Col + 1, Row) of
        0 -> check_cols_col(Col + 1, [Row | Rest], Rows, Cols);
        1 ->
            case Col + 1 < Cols of
                true -> 
                    case element(Col + 2, Row) of
                        0 -> check_cols_col(Col + 1, [Row | Rest], Rows, Cols);
                        _ -> false
                    end;
                false -> check_cols_col(Col + 1, [Row | Rest], Rows, Cols)
            end;
        _ -> false
    end.