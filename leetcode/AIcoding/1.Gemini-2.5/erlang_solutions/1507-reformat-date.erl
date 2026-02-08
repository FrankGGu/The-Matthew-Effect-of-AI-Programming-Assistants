-module(solution).
-export([reformatDate/1]).

reformatDate(DateString) ->
    [DayStr, MonthStr, YearStr] = string:tokens(DateString, " "),

    % Process Day
    DayLen = string:len(DayStr),
    NumericDayStr = string:substr(DayStr, 1, DayLen - 2),
    DayInt = list_to_integer(NumericDayStr),
    FormattedDay = lists:flatten(io_lib:format("~2.0.0B", [DayInt])),

    % Process Month
    FormattedMonth = case MonthStr of
        "Jan" -> "01";
        "Feb" -> "02";
        "Mar" -> "03";
        "Apr" -> "04";
        "May" -> "05";
        "Jun" -> "06";
        "Jul" -> "07";
        "Aug" -> "08";
        "Sep" -> "09";
        "Oct" -> "10";
        "Nov" -> "11";
        "Dec" -> "12"
    end,

    % Assemble the result
    lists:flatten(io_lib:format("~s-~s-~s", [YearStr, FormattedMonth, FormattedDay])).