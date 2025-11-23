-module(solution).
-export([min_absolute_difference/1]).

min_absolute_difference(Matrix) ->
    {Rows, Cols} = {length(Matrix), length(hd(Matrix))},
    MinDiff = find_min_diff(Matrix, Rows, Cols),
    MinDiff.

find_min_diff(Matrix, Rows, Cols) ->
    MinDiff = infinity,
    find_min_diff(Matrix, Rows, Cols, 1, 1, MinDiff).

find_min_diff(Matrix, Rows, Cols, I, J, MinDiff) when I + 1 > Rows ->
    if
        J + 1 > Cols -> MinDiff;
        true -> find_min_diff(Matrix, Rows, Cols, 1, J + 1, MinDiff)
    end;
find_min_diff(Matrix, Rows, Cols, I, J, MinDiff) when J + 1 > Cols ->
    find_min_diff(Matrix, Rows, Cols, I + 1, 1, MinDiff);
find_min_diff(Matrix, Rows, Cols, I, J, MinDiff) ->
    Current = abs(lists:nth(J, lists:nth(I, Matrix)) - lists:nth(J + 1, lists:nth(I, Matrix))),
    Down = abs(lists:nth(J, lists:nth(I, Matrix)) - lists:nth(J, lists:nth(I + 1, Matrix))),
    RightDown = abs(lists:nth(J, lists:nth(I, Matrix)) - lists:nth(J + 1, lists:nth(I + 1, Matrix))),
    NewMinDiff = lists:min([Current, Down, RightDown, MinDiff]),
    find_min_diff(Matrix, Rows, Cols, I, J + 1, NewMinDiff).