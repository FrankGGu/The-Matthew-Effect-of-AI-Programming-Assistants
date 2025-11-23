-module(solution).
-export([reformat_date/1]).

reformat_date(Date) ->
    [DayStr, MonthStr, YearStr] = string:tokens(Date, " "),
    Day = day_to_int(DayStr),
    Month = month_to_int(MonthStr),
    Year = YearStr,
    lists:flatten(io_lib:format("~s-~2..0s-~2..0s", [Year, Month, Day])).

day_to_int(DayStr) ->
    {Day, _} = string:to_integer(string:substr(DayStr, 1, length(DayStr) - 2)),
    integer_to_list(Day).

month_to_int(MonthStr) ->
    Months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", 
              "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
    {Index, _} = lists:keyfind(MonthStr, 1, lists:zip(Months, lists:seq(1, 12))),
    integer_to_list(Index).