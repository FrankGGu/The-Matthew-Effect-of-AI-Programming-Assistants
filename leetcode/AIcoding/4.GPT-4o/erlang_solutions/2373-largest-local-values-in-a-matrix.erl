-module(solution).
-export([largest_local/1]).

largest_local(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Result = lists:map(fun(Row) -> 
        lists:map(fun(Col) ->
            largest_in_square(Matrix, Row, Col)
        end, lists:seq(1, Cols - 2))
    end, lists:seq(1, Rows - 2)),
    Result.

largest_in_square(Matrix, Row, Col) ->
    Max = lists:max([
        lists:max([lists:nth(Col + DC, lists:nth(Row + DR, Matrix)) || DC <- lists:seq(-1, 1)]) || DR <- lists:seq(-1, 1)
    ]),
    Max.