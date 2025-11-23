-module(solution).
-export([dataframe_from_list/2]).

dataframe_from_list(Rows, ColumnNames) ->
    lists:map(fun(Row) -> maps:from_list(lists:zip(ColumnNames, Row)) end, Rows).