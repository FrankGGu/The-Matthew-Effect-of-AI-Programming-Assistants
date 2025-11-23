-module(excel_sheet_column_number).
-export([titleToNumber/1]).

titleToNumber(S) ->
    lists:foldl(fun(Char, Acc) ->
        Acc * 26 + (Char - $A + 1)
    end, 0, S).