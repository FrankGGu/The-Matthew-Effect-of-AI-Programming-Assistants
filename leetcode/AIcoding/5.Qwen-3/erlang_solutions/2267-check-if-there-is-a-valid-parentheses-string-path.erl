-module(solution).
-export([find_valid_path/1]).

find_valid_path(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    find_valid_path(Grid, 0, 0, 0, Rows, Cols).

find_valid_path(_, _, _, _, _, _) when (0 < 0) -> false;
find_valid_path(Grid, Row, Col, Balance, Rows, Cols) ->
    case Row of
        R when R >= Rows -> false;
        _ -> 
            case Col of
                C when C >= Cols -> false;
                _ -> 
                    Char = lists:nth(Row + 1, Grid),
                    CharAtCol = lists:nth(Col + 1, Char),
                    case CharAtCol of
                        $'(' -> 
                            if Balance + 1 > 2 * (Rows + Cols) -> false;
                               true -> find_valid_path(Grid, Row + 1, Col, Balance + 1, Rows, Cols) orelse find_valid_path(Grid, Row, Col + 1, Balance + 1, Rows, Cols)
                            end;
                        $')' -> 
                            if Balance - 1 < 0 -> false;
                               true -> find_valid_path(Grid, Row + 1, Col, Balance - 1, Rows, Cols) orelse find_valid_path(Grid, Row, Col + 1, Balance - 1, Rows, Cols)
                            end;
                        _ -> 
                            find_valid_path(Grid, Row + 1, Col, Balance, Rows, Cols) orelse find_valid_path(Grid, Row, Col + 1, Balance, Rows, Cols)
                    end
            end
    end.

find_valid_path(Grid, Row, Col, Balance, Rows, Cols) when Row == Rows - 1, Col == Cols - 1 ->
    Balance == 0.