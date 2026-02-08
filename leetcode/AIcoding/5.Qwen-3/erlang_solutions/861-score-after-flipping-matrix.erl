-module(solution).
-export([matrixScore/1]).

matrixScore(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    FlipRow = fun(Row, Index) ->
        case lists:nth(1, Row) of
            0 -> [1 - X || X <- Row];
            _ -> Row
        end
    end,
    Grid1 = [FlipRow(Row, I) || {Row, I} <- lists:zip(Grid, lists:seq(1, Rows))],
    FlipCol = fun(ColIndex) ->
        Count = lists:foldl(fun(Row, Acc) -> Acc + lists:nth(ColIndex, Row) end, 0, Grid1),
        if Count < (Rows - Count) -> true; true -> false end
    end,
    Grid2 = lists:foldl(fun(ColIndex, Acc) ->
        if FlipCol(ColIndex) ->
            lists:map(fun(Row) -> lists:sublist(Row, ColIndex-1) ++ [1 - lists:nth(ColIndex, Row)] ++ lists:sublist(Row, ColIndex+1, length(Row)-ColIndex) end, Acc);
           true -> Acc
        end
    end, Grid1, lists:seq(1, Cols)),
    Score = lists:foldl(fun(Row, Acc) -> Acc + lists:sum(Row) end, 0, Grid2),
    Score.