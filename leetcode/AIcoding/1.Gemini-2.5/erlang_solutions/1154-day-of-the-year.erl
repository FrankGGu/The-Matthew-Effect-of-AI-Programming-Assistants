-module(solution).
-export([day_of_year/1]).

-spec day_of_year(Date :: unicode:unicode_binary()) -> integer().
day_of_year(Date) ->
    [YearStr, MonthStr, DayStr] = binary:split(Date, <<"-">>),
    Year = binary_to_integer(YearStr),
    Month = binary_to_integer(MonthStr),
    Day = binary_to_integer(DayStr),

    IsLeap = is_leap_year(Year),

    MonthDays = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31], 

    SumPrevMonths = sum_previous_months(1, Month - 1, IsLeap, MonthDays),

    SumPrevMonths + Day.

sum_previous_months(CurrentMonth, TargetMonth, IsLeap, MonthDays) ->
    if CurrentMonth > TargetMonth ->
        0;
    true ->
        DaysInCurrentMonth = lists:nth(CurrentMonth, MonthDays),
        AdjustedDays = 
            if CurrentMonth == 2 andalso IsLeap -> DaysInCurrentMonth + 1;
               true -> DaysInCurrentMonth
            end,
        AdjustedDays + sum_previous_months(CurrentMonth + 1, TargetMonth, IsLeap, MonthDays)
    end.

is_leap_year(Y) ->
    (Y rem 4 == 0 andalso Y rem 100 /= 0) orelse (Y rem 400 == 0).