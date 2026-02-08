-module(latest_time).
-export([maximum_time/1]).

maximum_time(Time) ->
    TimeList = string:to_list(Time),
    MaxTimeList = replace_digits(TimeList),
    string:from_list(MaxTimeList).

replace_digits([H, M1, M2, S1, S2]) ->
    [H, replace_digit(M1, $0, $5), replace_digit(M2, $0, $9), S1, S2].

replace_digit(Digit, Low, High) when Digit == $? ->
    High;
replace_digit(Digit, Low, High) when Digit >= Low, Digit =< High ->
    Digit;
replace_digit(Digit, Low, High) ->
    Low.