-module(solution).
-export([reformat_date/1]).

reformat_date(Date) ->
    MonthMap = #{"Jan" => "01", "Feb" => "02", "Mar" => "03", "Apr" => "04", 
                 "May" => "05", "Jun" => "06", "Jul" => "07", "Aug" => "08", 
                 "Sep" => "09", "Oct" => "10", "Nov" => "11", "Dec" => "12"},
    [Day, Month, Year] = string:tokens(Date, " "),
    DayNum = binary_to_integer(string:trim(Day, right, "thrdst")),
    MonthNum = maps:get(Month, MonthMap),
    io_lib:format("~2..0B-~s-~4..0B", [DayNum, MonthNum, binary_to_integer(Year)]).