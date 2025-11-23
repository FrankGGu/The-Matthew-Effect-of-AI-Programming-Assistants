-module(maximum_difference_score_in_grid).
-export([maxDifference: 1]).

maxDifference(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxDiff = -infinity,
    lists:foldl(fun(RowIdx, Acc) ->
        lists:foldl(fun(ColIdx, Acc2) ->
            Value = lists:nth(RowIdx+1, Grid) -- [ColIdx+1],
            Diff = getRowMax(Grid, RowIdx) - getColMin(Grid, ColIdx),
            max(Acc2, Diff)
        end, Acc, lists:seq(0, Cols-1))
    end, MaxDiff, lists:seq(0, Rows-1)).

getRowMax(Grid, RowIdx) ->
    lists:max(lists:nth(RowIdx+1, Grid)).

getColMin(Grid, ColIdx) ->
    lists:min([lists:nth(ColIdx+1, Row) || Row <- Grid]).