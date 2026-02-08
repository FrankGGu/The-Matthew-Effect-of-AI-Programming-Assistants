-module(minimum_cost_homecoming).
-export([minCost/2]).

minCost(Rows, Cols) ->
    minCost(Rows, Cols, 0, 0, 0, 0).

minCost([], _, _, _, _, _) -> 0;
minCost([H|T], Cols, Row, Col, Cost, Dir) ->
    NewRow = Row + H,
    NewCol = Col + Cols,
    NewCost = Cost + abs(H) + abs(Cols),
    minCost(T, Cols, NewRow, NewCol, NewCost, Dir).