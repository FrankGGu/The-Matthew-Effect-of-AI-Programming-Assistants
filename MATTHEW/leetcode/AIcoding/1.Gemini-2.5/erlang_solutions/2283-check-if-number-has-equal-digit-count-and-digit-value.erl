-module(solution).
-export([digit_count_value/1]).

digit_count_value(NumString) ->
    NumList = string:to_list(NumString),
    Len = length(NumList),
    check(NumList, 0, Len).

check(_NumList, Index, Len) when Index == Len ->
    true;
check(NumList, Index, Len) ->
    ExpectedCountChar = lists:nth(Index + 1, NumList),
    ExpectedCount = ExpectedCountChar - $0,

    ActualCount = count_digit(Index, NumList),

    if ExpectedCount == ActualCount ->
        check(NumList, Index + 1, Len);
    true ->
        false
    end.

count_digit(Digit, NumList) ->
    length([C || C <- NumList, (C - $0) == Digit]).