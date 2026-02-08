-module(solution).
-export([shiftGrid/2]).

shiftGrid(Grid, K) ->
    RowCount = length(Grid),
    ColCount = length(hd(Grid)),
    TotalElements = RowCount * ColCount,
    K1 = K rem TotalElements,
    FlatGrid = lists:flat(Grid),
    ShiftedGrid = lists:sublist(FlatGrid, TotalElements - K1) ++ lists:sublist(FlatGrid, 1, TotalElements - K1),
    split_grid(ShiftedGrid, RowCount, ColCount).

split_grid([], _, _) -> [];
split_grid(Grid, RowCount, ColCount) ->
    [lists:sublist(Grid, 0, ColCount) | split_grid(lists:sublist(Grid, ColCount), RowCount - 1, ColCount)].