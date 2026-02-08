-module(solution).
-export([num_special_positions/1]).

num_special_positions(Matrix) ->
    Rows = length(Matrix),
    Cols = case Rows of
        0 -> 0;
        _ -> length(hd(Matrix))
    end,
    Count = lists:foldl(fun(Row, Acc) ->
        Acc + special_position(Row, Matrix, Rows, Cols)
    end, 0, Matrix),
    Count.

special_position(Row, Matrix, Rows, Cols) ->
    Index = lists:index(Row, Matrix),
    SumRow = lists:sum(Row),
    SumCol = lists:sum(lists:map(fun R -> lists:nth(Index + 1, R) end, Matrix)),
    if
        lists:nth(Index + 1, Row) == 1, 
        SumRow == 1, 
        SumCol == 1 -> 1;
        true -> 0
    end.