-module(solution).
-export([daysBetweenDates/2]).

is_leap(Y) ->
    (Y rem 4 == 0 andalso Y rem 100 =/= 0) orelse (Y rem 400 == 0).

days_in_month(2, Y) when is_leap(Y) -> 29;
days_in_month(2, _) -> 28;
days_in_month(4, _) -> 30;
days_in_month(6, _) -> 30;
days_in_month(9, _) -> 30;
days_in_month(11, _) -> 30;
days_in_month(_, _) -> 31.

total_days_from_epoch(Y, M, D) ->
    DaysFromYears = lists:sum([if is_leap(Yr) -> 366; true -> 365 end || Yr <- lists:seq(1, Y - 1)]),
    DaysFromMonths = lists:sum([days_in_month(Mr, Y) || Mr <- lists:seq(1, M - 1)]),
    DaysFromYears + DaysFromMonths + D.

parse_date(DateStr) ->
    [Y_str, M_str, D_str] = string:split(DateStr, "-", [global]),
    {list_to_integer(Y_str), list_to_integer(M_str), list_to_integer(D_str)}.

daysBetweenDates(Date1, Date2) ->
    {Y1, M1, D1} = parse_date(Date1),
    {Y2, M2, D2} = parse_date(Date2),
    Days1 = total_days_from_epoch(Y1, M1, D1),
    Days2 = total_days_from_epoch(Y2, M2, D2),
    abs(Days1 - Days2).