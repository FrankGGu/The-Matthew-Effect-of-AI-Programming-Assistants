-module(minimum_path_sum).
-export([minPathSum/1]).

minPathSum(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    DP = array:new({0, Rows-1}, {0, Cols-1}, 0),
    DP1 = array:set(0, 0, array:get(0, 0, Grid), DP),
    min_path_sum(Grid, DP, 0, 0, Rows, Cols).

min_path_sum(Grid, DP, Row, Col, Rows, Cols) when Row == Rows-1, Col == Cols-1 ->
    array:get(Row, Col, DP);

min_path_sum(Grid, DP, Row, Col, Rows, Cols) ->
    Current = array:get(Row, Col, Grid),
    NextRow = Row + 1,
    NextCol = Col + 1,
    if
        Row == Rows-1 ->
            NewVal = Current + array:get(Row, Col-1, DP),
            DP1 = array:set(Row, Col, NewVal, DP),
            min_path_sum(Grid, DP1, Row, NextCol, Rows, Cols);
        Col == Cols-1 ->
            NewVal = Current + array:get(Row-1, Col, DP),
            DP1 = array:set(Row, Col, NewVal, DP),
            min_path_sum(Grid, DP1, NextRow, Col, Rows, Cols);
        true ->
            Up = array:get(Row-1, Col, DP),
            Left = array:get(Row, Col-1, DP),
            Min = min(Up, Left),
            NewVal = Current + Min,
            DP1 = array:set(Row, Col, NewVal, DP),
            min_path_sum(Grid, DP1, NextRow, NextCol, Rows, Cols)
    end.