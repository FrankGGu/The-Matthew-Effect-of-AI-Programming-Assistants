-module(solution).
-export([dropMissingData/1]).

dropMissingData(Rows) ->
    lists:filter(fun(Row) -> not lists:member(null, Row) end, Rows).