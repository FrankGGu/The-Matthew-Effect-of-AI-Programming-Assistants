-module(reformat_date).
-export([reformat_date/1]).

reformat_date(Date) ->
    [Day, Month, Year] = string:split(Date, " "),
    DayNum = list_to_integer(Day),
    MonthNum = month_to_num(Month),
    io_lib:format("~s-~2.2.0w-~2.2.0w", [Year, MonthNum, DayNum]).

month_to_num("Jan") -> 1;
month_to_num("Feb") -> 2;
month_to_num("Mar") -> 3;
month_to_num("Apr") -> 4;
month_to_num("May") -> 5;
month_to_num("Jun") -> 6;
month_to_num("Jul") -> 7;
month_to_num("Aug") -> 8;
month_to_num("Sep") -> 9;
month_to_num("Oct") -> 10;
month_to_num("Nov") -> 11;
month_to_num("Dec") -> 12.