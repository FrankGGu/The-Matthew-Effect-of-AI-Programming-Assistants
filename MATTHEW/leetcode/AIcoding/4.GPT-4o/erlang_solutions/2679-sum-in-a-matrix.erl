-module(solution).
-export([matrixSum/1]).

matrixSum(Matrix) ->
    RowMaxes = lists:map(fun(Row) -> lists:max(Row) end, Matrix),
    lists:sum(RowMaxes).