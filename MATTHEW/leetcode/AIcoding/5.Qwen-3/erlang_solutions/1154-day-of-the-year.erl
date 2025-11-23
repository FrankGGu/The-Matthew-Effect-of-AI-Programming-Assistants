-module(day_of_the_year).
-export([day_of_the_year/1]).

day_of_the_year(Date) ->
    [Year, Month, Day] = parse_date(Date),
    DaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
    IsLeap = is_leap(Year),
    if
        IsLeap -> lists:sublist(DaysInMonth, 1, 2) ++ [29 | lists:nthtail(2, DaysInMonth)];
        true -> DaysInMonth
    end,
    Total = lists:sum(lists:sublist(DaysInMonth, 1, Month - 1)) + Day,
    Total.

parse_date(Date) ->
    [Y, M, D] = string:split(Date, "-"),
    [list_to_integer(Y), list_to_integer(M), list_to_integer(D)].

is_leap(Year) ->
    (Year rem 4 == 0 andalso Year rem 100 /= 0) orelse (Year rem 400 == 0).