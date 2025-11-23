-module(stamping_the_grid).
-export([grid_stamp/2]).

grid_stamp(Grid, Stamp) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    StampRows = length(Stamp),
    StampCols = length(hd(Stamp)),
    GridWithStamps = lists:foldl(fun({row, R}, Acc) ->
        lists:foldl(fun({col, C}, A) ->
            case can_stamp(Acc, R, C, Stamp, Rows, Cols, StampRows, StampCols) of
                true -> stamp(A, R, C, Stamp, StampRows, StampCols);
                false -> A
            end
        end, Acc, lists:seq(0, Cols - 1))
    end, Grid, lists:seq(0, Rows - 1)),
    all_stamped(GridWithStamps).

can_stamp(Grid, Row, Col, Stamp, Rows, Cols, StampRows, StampCols) ->
    lists:forall(fun(R) ->
        lists:forall(fun(C) ->
            case (R < StampRows, C < StampCols) of
                {true, true} ->
                    case lists:nth(R + 1, lists:nth(Row + R + 1, Grid)) of
                        '#' -> false;
                        _ -> true
                    end;
                _ -> true
            end
        end, lists:seq(0, StampCols - 1))
    end, lists:seq(0, StampRows - 1)).

stamp(Grid, Row, Col, Stamp, StampRows, StampCols) ->
    lists:foldl(fun(R, Acc) ->
        lists:foldl(fun(C, A) ->
            case (R < StampRows, C < StampCols) of
                {true, true} ->
                    lists:replace(Row + R + 1, '#', lists:nth(Row + R + 1, A), Col + C + 1);
                _ -> A
            end
        end, Acc, lists:seq(0, StampCols - 1))
    end, Grid, lists:seq(0, StampRows - 1)).

all_stamped(Grid) ->
    lists:all(fun(Row) ->
        lists:all(fun(Cell) -> Cell = '#' end, Row)
    end, Grid).