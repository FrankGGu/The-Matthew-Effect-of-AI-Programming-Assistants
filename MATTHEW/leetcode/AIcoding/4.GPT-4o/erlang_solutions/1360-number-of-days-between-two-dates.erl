-module(solution).
-export([days_between_dates/2]).

days_between_dates(Date1, Date2) ->
    {Year1, Month1, Day1} = parse_date(Date1),
    {Year2, Month2, Day2} = parse_date(Date2),
    Days1 = days_from_epoch(Year1, Month1, Day1),
    Days2 = days_from_epoch(Year2, Month2, Day2),
    abs(Days2 - Days1).

parse_date(Date) ->
    [Year, Month, Day] = string:tokens(Date, "-"),
    {list_to_integer(Year), list_to_integer(Month), list_to_integer(Day)}.

days_from_epoch(Year, Month, Day) ->
    TotalDays = (Year - 1970) * 365 + (Year - 1970) div 4 - (Year - 1970) div 100 + (Year - 1970) div 400,
    MonthDays = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
    DaysInYear = lists:sum(lists:sublist(MonthDays, 1, Month)) + (if is_leap_year(Year) andalso Month > 2 -> 1; true -> 0 end),
    TotalDays + DaysInYear + Day.

is_leap_year(Year) -> 
    (Year rem 4 =:= 0 andalso Year rem 100 =/= 0) orelse (Year rem 400 =:= 0).