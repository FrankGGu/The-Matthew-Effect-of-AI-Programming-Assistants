-module(solution).
-export([allCellsDistOrder/4]).

allCellsDistOrder(R, C, R0, C0) ->
    CellsWithDistances = [
        {abs(Row - R0) + abs(Col - C0), [Row, Col]}
        || Row <- lists:seq(0, R - 1),
           Col <- lists:seq(0, C - 1)
    ],
    SortedCellsWithDistances = lists:sort(CellsWithDistances),
    [Cell || {_, Cell} <- SortedCellsWithDistances].