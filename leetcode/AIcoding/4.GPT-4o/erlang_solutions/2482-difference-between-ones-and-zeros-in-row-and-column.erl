-module(solution).
-export([diff_ones_zeros/1]).

diff_ones_zeros(Matrix) ->
    RowDiffs = lists:map(fun(Row) -> count(Row) end, Matrix),
    Cols = lists:transpose(Matrix),
    ColDiffs = lists:map(fun(Col) -> count(Col) end, Cols),
    {RowDiffs, ColDiffs}.

count(List) ->
    Ones = lists:filter(fun(X) -> X == 1 end, List),
    Zeros = lists:filter(fun(X) -> X == 0 end, List),
    length(Ones) - length(Zeros).