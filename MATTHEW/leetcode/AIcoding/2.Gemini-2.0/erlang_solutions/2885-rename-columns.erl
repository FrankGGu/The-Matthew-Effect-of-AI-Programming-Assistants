-module(solution).
-export([rename_columns/2]).

rename_columns(Data, Columns) ->
  lists:map(fun(Row) -> rename_row(Row, Columns) end, Data).

rename_row(Row, Columns) ->
  lists:zip(Columns, Row).