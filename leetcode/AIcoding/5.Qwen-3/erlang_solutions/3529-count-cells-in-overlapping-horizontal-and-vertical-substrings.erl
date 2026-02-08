-module(solution).
-export([count_cells/1]).

count_cells(Str) ->
    count_cells(Str, 0, 0, 0, []).

count_cells([], _, _, _, Acc) ->
    lists:sum(Acc);
count_cells([H | T], Row, Col, Count, Acc) ->
    case H of
        $H ->
            NewRow = Row + 1,
            NewCol = 0,
            NewCount = 0,
            count_cells(T, NewRow, NewCol, NewCount, Acc);
        $V ->
            NewRow = Row,
            NewCol = Col + 1,
            NewCount = 0,
            count_cells(T, NewRow, NewCol, NewCount, Acc);
        $C ->
            NewRow = Row,
            NewCol = Col,
            NewCount = Count + 1,
            count_cells(T, NewRow, NewCol, NewCount, Acc);
        _ ->
            count_cells(T, Row, Col, Count, Acc)
    end.