-module(solution).
-export([minimum_flips/1]).

minimum_flips(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    min_flips(Grid, Rows, Cols, 0).

min_flips(_, _, Cols, Acc) when Cols == 0 -> Acc;
min_flips(Grid, Rows, Cols, Acc) ->
    Row1 = 0,
    Row2 = Rows - 1,
    Col = Cols - 1,
    Val1 = lists:nth(Col + 1, lists:nth(Row1 + 1, Grid)),
    Val2 = lists:nth(Col + 1, lists:nth(Row2 + 1, Grid)),
    case Val1 == Val2 of
        true -> min_flips(Grid, Rows, Cols - 1, Acc);
        false -> min_flips(Grid, Rows, Cols - 1, Acc + 1)
    end.