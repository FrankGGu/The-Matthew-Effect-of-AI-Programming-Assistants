-module(solution).
-export([rename_columns/1]).

rename_columns(Columns) ->
    lists:map(fun({Key, Value}) -> {Key, Value + 1} end, Columns).