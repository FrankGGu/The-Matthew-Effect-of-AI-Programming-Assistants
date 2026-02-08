-module(solution).
-export([convert_date_to_binary/1]).

convert_date_to_binary(Date) ->
    [Y, M, D] = string:tokens(Date, "-"),
    Year = list_to_integer(Y),
    Month = list_to_integer(M),
    Day = list_to_integer(D),
    YearBin = integer_to_list(Year, 2),
    MonthBin = integer_to_list(Month, 2),
    DayBin = integer_to_list(Day, 2),
    lists:concat([YearBin, MonthBin, DayBin]).