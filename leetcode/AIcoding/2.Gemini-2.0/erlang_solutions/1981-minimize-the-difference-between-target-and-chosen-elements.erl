-module(minimize_the_difference).
-export([min_absolute_difference/2]).

min_absolute_difference(Mat, Target) ->
    Rows = length(Mat),
    FirstRow = lists:nth(1, Mat),
    min_absolute_difference_helper(Mat, 2, Rows, FirstRow, Target).

min_absolute_difference_helper(_Mat, Row, Rows, Acc, Target) when Row > Rows ->
    lists:foldl(
        fun(X, MinDiff) ->
            Diff = abs(X - Target),
            min(MinDiff, Diff)
        end,
        infinity,
        Acc
    );
min_absolute_difference_helper(Mat, Row, Rows, Acc, Target) ->
    NextRow = lists:nth(Row, Mat),
    NewAcc = lists:flatten([
        [A + N || N <- NextRow] || A <- Acc
    ]),
    min_absolute_difference_helper(Mat, Row + 1, Rows, NewAcc, Target).

infinity() ->
    1 bsl 60.