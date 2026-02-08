-spec min_cost_homecoming(HomePos :: [integer()], RowCosts :: [integer()], ColCosts :: [integer()]) -> integer().
min_cost_homecoming(HomePos, RowCosts, ColCosts) ->
    [HomeRow, HomeCol] = HomePos,
    StartRow = 0,
    StartCol = 0,
    RowCost = lists:sum(lists:sublist(RowCosts, min(StartRow, HomeRow) + 1, abs(HomeRow - StartRow) + 1),
    ColCost = lists:sum(lists:sublist(ColCosts, min(StartCol, HomeCol) + 1, abs(HomeCol - StartCol) + 1),
    RowCost + ColCost.