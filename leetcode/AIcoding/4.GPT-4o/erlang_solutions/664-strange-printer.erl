-module(strange_printer).
-export([strangePrinter/1]).

strangePrinter(Str) ->
    N = string:length(Str),
    Memo = lists:duplicate(N, lists:duplicate(N, -1)),
    strange_printer_helper(Str, 0, N - 1, Memo).

strange_printer_helper(Str, L, R, Memo) ->
    case lists:nth(L + 1, lists:nth(R + 1, Memo)) of
        -1 ->
            if
                L > R -> 0;
                true ->
                    Result = strange_printer_helper(Str, L + 1, R, Memo) + 1,
                    if
                        L < R, string:substr(Str, L + 1, 1) =:= string:substr(Str, L, 1) ->
                            Result = strange_printer_helper(Str, L + 1, R, Memo)
                    end,
                    Memo1 = lists:update_element(R + 1, lists:update_element(L + 1, Result, lists:nth(L + 1, lists:nth(R + 1, Memo))), Memo),
                    Result
            end;
        Result -> Result
    end.