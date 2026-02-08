-module(solution).
-export([min_flips/1]).

min_flips(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Flips = lists:foldl(fun(Row, Acc) ->
        RowFlips = lists:foldl(fun({X, Y}, Acc2) ->
            case {lists:nth(X + 1, Grid), lists:nth(Y + 1, Grid)} of
                {Row1, Row2} -> Acc2 + (if Row1 =/= Row2 -> 1; true -> 0 end)
            end
        end, 0, lists:seq(0, div(Cols - 1, 2))),
        Acc + RowFlips
    end, 0, lists:seq(0, div(Rows - 1, 2))),
    Flips.