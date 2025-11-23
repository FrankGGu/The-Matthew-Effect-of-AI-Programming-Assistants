-module(solution).
-export([melt/1]).

melt(DataFrame) ->
  melt(DataFrame, 1, []).

melt([], _, Acc) ->
  lists:reverse(Acc);
melt([Row | Rest], RowIndex, Acc) ->
  melt_row(Row, RowIndex, 1, Rest, Acc).

melt_row([], _, _, Rest, Acc) ->
  melt(Rest, length(Acc) + 2, Acc);
melt_row([{ColumnName, Value} | Columns], RowIndex, ColumnIndex, Rest, Acc) ->
  melt_row(Columns, RowIndex, ColumnIndex + 1, Rest, [{<<"id">>, RowIndex}, {<<"variable">>, ColumnName}, {<<"value">>, Value}] ++ Acc).