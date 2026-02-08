-module(balanced_string_split).
-export([balanced_string_split/1]).

balanced_string_split(S) ->
    balanced_string_split(S, 0, 0, 0).

balanced_string_split([], _, Count, Result) ->
    Result;
balanced_string_split([H|T], Balance, Count, Result) ->
    NewBalance = case H of
        $L -> Balance + 1;
        $R -> Balance - 1
    end,
    NewCount = Count + 1,
    NewResult = case NewBalance of
        0 -> Result + 1;
        _ -> Result
    end,
    balanced_string_split(T, NewBalance, NewCount, NewResult).