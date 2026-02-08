-module(solution).
-export([day_of_year/3]).

day_of_year(Year, Month, Day) ->
    DaysInMonth = [31, if Month > 2 -> 28; true -> 29 end, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
    DaysBefore = lists:sum(lists:sublist(DaysInMonth, 1, Month - 1)),
    DaysBefore + Day.