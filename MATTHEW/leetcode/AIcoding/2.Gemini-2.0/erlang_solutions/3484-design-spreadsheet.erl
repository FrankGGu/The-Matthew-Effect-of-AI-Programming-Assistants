-module(spreadsheet).
-export([new_spreadsheet/1, set_cell/3, get_cell/2]).

new_spreadsheet(Size) ->
  lists:duplicate(Size, lists:duplicate(Size, "")).

set_cell(Spreadsheet, Row, Col, Value) ->
  lists:nth(Row, lists:nth(Col, lists:nth(1,lists:zip(Spreadsheet, lists:seq(1,length(Spreadsheet)))))) = Value,
  Spreadsheet.

get_cell(Spreadsheet, Row, Col) ->
  try
    lists:nth(Row, lists:nth(Col, lists:nth(1,lists:zip(Spreadsheet, lists:seq(1,length(Spreadsheet))))))
  catch
    _:_ ->
      ""
  end.