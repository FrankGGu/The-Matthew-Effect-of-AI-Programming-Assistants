-module(solution).
-export([drone_square/1]).

drone_square(N) when N rem 2 == 0 ->
    {error, "N must be an odd number"};
drone_square(N) ->
    Grid = lists:duplicate(N, lists:duplicate(N, 0)),
    FinalGrid = fill_grid(Grid, N, 0, 0, 1),
    FinalGrid.

fill_grid(Grid, N, Row, Col, Value) when Value > N * N ->
    Grid;
fill_grid(Grid, N, Row, Col, Value) ->
    NewGrid = lists:update_element(Row + 1, lists:update_element(Col + 1, Value, lists:nth(Row + 1, Grid)), Grid),
    NewRow = (Row - 1 + N) rem N,
    NewCol = (Col + 1) rem N,
    fill_grid(NewGrid, N, NewRow, NewCol, Value + 1).