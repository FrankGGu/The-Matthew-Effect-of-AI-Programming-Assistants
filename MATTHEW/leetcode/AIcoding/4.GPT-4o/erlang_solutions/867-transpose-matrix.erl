-module(solution).
-export([transpose/1]).

transpose(Matrix) ->
    lists:map(fun(Row) -> lists:map(fun(Index) -> lists:nth(Index + 1, Row) end, lists:seq(0, length(Row) - 1)) end, lists:seq(0, length(Matrix) - 1)).