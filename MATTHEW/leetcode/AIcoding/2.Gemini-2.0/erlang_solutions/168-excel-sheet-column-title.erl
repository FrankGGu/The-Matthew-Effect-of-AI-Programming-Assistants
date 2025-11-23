-module(excel_sheet_column_title).
-export([convert_to_title/1]).

convert_to_title(N) ->
    convert_to_title_helper(N, []).

convert_to_title_helper(0, Acc) ->
    list_to_binary(lists:reverse(Acc));
convert_to_title_helper(N, Acc) ->
    N1 = (N - 1) div 26,
    R = (N - 1) rem 26,
    convert_to_title_helper(N1, [R + $A | Acc]).