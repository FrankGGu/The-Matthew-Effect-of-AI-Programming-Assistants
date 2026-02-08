-module(minimum_cost_homecoming).
-export([min_cost_homecoming/4]).

min_cost_homecoming(StartPos, HomePos, RowCosts, ColCosts) ->
    {StartRow, StartCol} = StartPos,
    {HomeRow, HomeCol} = HomePos,
    RowCost = row_cost(StartRow, HomeRow, RowCosts),
    ColCost = col_cost(StartCol, HomeCol, ColCosts),
    RowCost + ColCost.

row_cost(StartRow, HomeRow, RowCosts) ->
    if StartRow == HomeRow then
        0
    else
        Cost = lists:sum([RowCosts ! I || I <- seq(min(StartRow, HomeRow) + 1, max(StartRow, HomeRow))]),
        Cost
    end.

col_cost(StartCol, HomeCol, ColCosts) ->
    if StartCol == HomeCol then
        0
    else
        Cost = lists:sum([ColCosts ! I || I <- seq(min(StartCol, HomeCol) + 1, max(StartCol, HomeCol))]),
        Cost
    end.

seq(Start, End) ->
    if Start > End then
        []
    else
        [Start | seq(Start + 1, End)]
    end.