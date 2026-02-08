-module(excel_sheet_column_number).
-export([title_to_number/1]).

title_to_number(Title) ->
  title_to_number(Title, 0).

title_to_number("", Acc) ->
  Acc;
title_to_number([H|T], Acc) ->
  Value = H - $A + 1,
  title_to_number(T, Acc * 26 + Value).