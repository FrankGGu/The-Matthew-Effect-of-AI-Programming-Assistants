-module(solution).
-export([convertDateToBinary/1]).

convertDateToBinary(DateStr) ->
    [YearStr, MonthStr, DayStr] = string:tokens(DateStr, "-"),
    Year = list_to_integer(YearStr),
    Month = list_to_integer(MonthStr),
    Day = list_to_integer(DayStr),
    calendar:date_to_gregorian_days(Year, Month, Day).