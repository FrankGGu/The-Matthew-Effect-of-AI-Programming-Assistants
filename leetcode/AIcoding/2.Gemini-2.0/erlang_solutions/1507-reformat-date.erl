-module(reformat_date).
-export([reformatDate/1]).

reformatDate(Date) ->
    [DayS, MonthS, YearS] = string:split(Date, " ", all),
    Day = list_to_integer(string:slice(DayS, 0, length(DayS) - 2)),
    Month = month_to_number(MonthS),
    io_lib:format("~p-~2.2w-~2.2w", [YearS, Month, Day]).

month_to_number(Month) ->
    case Month of
        "Jan" -> 1;
        "Feb" -> 2;
        "Mar" -> 3;
        "Apr" -> 4;
        "May" -> 5;
        "Jun" -> 6;
        "Jul" -> 7;
        "Aug" -> 8;
        "Sep" -> 9;
        "Oct" -> 10;
        "Nov" -> 11;
        "Dec" -> 12
    end.