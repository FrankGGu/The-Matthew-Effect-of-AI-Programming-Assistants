-module(solution).
-export([min_flips/1]).

min_flips(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    min_flips(Grid, 0, 0, 0).

min_flips(_, R, C, Acc) when R >= Rows -> Acc;
min_flips(Grid, R, C, Acc) when C >= Cols -> min_flips(Grid, R+1, 0, Acc);
min_flips(Grid, R, C, Acc) ->
    Row = lists:nth(R+1, Grid),
    Val = lists:nth(C+1, Row),
    OppositeC = Cols - C - 1,
    OppositeVal = lists:nth(OppositeC+1, Row),
    if
        Val == OppositeVal -> min_flips(Grid, R, C+1, Acc);
        true -> min_flips(Grid, R, C+1, Acc + 1)
    end.