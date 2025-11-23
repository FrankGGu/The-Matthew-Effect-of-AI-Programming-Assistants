-module(path_encryption).
-export([solve/1]).

solve(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    solve(Grid, Rows, Cols, 0, 0, []).

solve(_Grid, Rows, Cols, Rows, _Col, Acc) ->
    lists:reverse(Acc);
solve(_Grid, Rows, Cols, _Row, Cols, Acc) ->
    lists:reverse(Acc);
solve(Grid, Rows, Cols, Row, Col, Acc) ->
    Val = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
    case Val of
        0 ->
            [];
        1 ->
            solve(Grid, Rows, Cols, Row + 1, Col, [1 | Acc]) ++ solve(Grid, Rows, Cols, Row, Col + 1, [1 | Acc]);
        _ ->
            solve(Grid, Rows, Cols, Rows, Cols, Acc)
    end.