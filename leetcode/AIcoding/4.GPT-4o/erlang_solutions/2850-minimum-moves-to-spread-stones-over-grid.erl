-module(solution).
-export([min_moves/1]).

min_moves(Grid) ->
    Stones = lists:sum(lists:flatten(Grid)),
    {Rows, Cols} = {length(Grid), length(hd(Grid))},
    Target = div(Stones, Rows * Cols),
    Extra = Stones rem (Rows * Cols),
    lists:foldl(fun(RowAcc, Acc) ->
        RowSum = lists:sum(RowAcc),
        Acc + max(0, RowSum - Target) + max(0, Target - RowSum - (if Extra > 0 -> 1; true -> 0 end))
    end, 0, Grid) div 2.