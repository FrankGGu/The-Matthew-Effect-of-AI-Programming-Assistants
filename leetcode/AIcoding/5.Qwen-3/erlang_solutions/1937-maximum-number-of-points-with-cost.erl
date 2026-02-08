-module(max_points).
-export([maxPoints/1]).

maxPoints(Points) ->
    Rows = length(Points),
    Cols = length(hd(Points)),
    Max = lists:seq(0, Cols - 1),
    maxPoints(Points, Rows, Cols, Max, 0).

maxPoints(_, _, Cols, Max, Row) when Row >= Cols ->
    lists:max(Max);
maxPoints(Points, Rows, Cols, Max, Row) ->
    CurrentRow = lists:nth(Row + 1, Points),
    NewMax = lists:zipwith(fun(I, Val) ->
        lists:max([lists:nth(I + 1, CurrentRow) + lists:nth(J + 1, Max) || J <- lists:seq(0, Cols - 1), abs(J - I) < 2])
    end, lists:seq(0, Cols - 1), CurrentRow),
    maxPoints(Points, Rows, Cols, NewMax, Row + 1).