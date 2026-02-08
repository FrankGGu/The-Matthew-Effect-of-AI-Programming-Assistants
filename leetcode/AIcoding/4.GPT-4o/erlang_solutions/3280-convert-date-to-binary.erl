-module(solution).
-export([convertDate/1]).

convertDate(Date) ->
    {Year, Month, Day} = parse_date(Date),
    YearBin = integer_to_binary(Year),
    MonthBin = integer_to_binary(Month),
    DayBin = integer_to_binary(Day),
    YearBin ++ "-" ++ MonthBin ++ "-" ++ DayBin.

parse_date(Date) ->
    {Year, Month, Day} = string:to_integer(Date),
    {Year, Month, Day}.