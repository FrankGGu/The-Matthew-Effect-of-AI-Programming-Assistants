-module(solution).
-export([min_path_cost/2]).

min_path_cost(Grid, MoveCosts) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    CostGrid = lists:duplicate(Rows, lists:duplicate(Cols, 0)),
    lists:foldl(fun({Row, RowIdx}, Acc) ->
        lists:foldl(fun({Cost, ColIdx}, AccRow) ->
            MinPrevCost = case RowIdx of
                0 -> 0;
                _ -> lists:min(get_prev_costs(Acc, RowIdx, ColIdx))
            end,
            NewCost = Cost + MinPrevCost,
            lists:replace(AccRow, ColIdx, NewCost)
        end, Acc, lists:zip(Row, lists:seq(0, Cols - 1))
        )
    end, CostGrid, lists:zip(Grid, lists:seq(0, Rows - 1))),
    lists:min(last(CostGrid)).

get_prev_costs(CostGrid, RowIdx, ColIdx) ->
    PrevCosts = [],
    if 
        ColIdx > 0 -> PrevCosts = [lists:nth(ColIdx - 1, lists:nth(RowIdx, CostGrid)) | PrevCosts]
    end,
    if 
        RowIdx > 0 -> PrevCosts = [lists:nth(ColIdx, lists:nth(RowIdx - 1, CostGrid)) | PrevCosts]
    end,
    PrevCosts.

last(List) ->
    lists:last(List).