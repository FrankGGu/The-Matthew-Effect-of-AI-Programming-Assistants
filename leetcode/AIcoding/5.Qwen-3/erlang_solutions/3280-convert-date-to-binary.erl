-module(convert_date_to_binary).
-export([convert_date_to_binary/3]).

convert_date_to_binary(Year, Month, Day) ->
    YearBin = integer_to_binary(Year),
    MonthBin = integer_to_binary(Month),
    DayBin = integer_to_binary(Day),
    <<YearBin/binary, $/, 16#2f, MonthBin/binary, $/, 16#2f, DayBin/binary>>.

integer_to_binary(N) ->
    binary:encode_unsigned(N).