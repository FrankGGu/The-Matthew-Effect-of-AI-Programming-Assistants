-module(count_days_without_meetings).
-export([count_days/2]).

count_days(Start, End) ->
    Count = 0,
    Days = lists:seq(Start, End),
    lists:foldl(fun(Day, Acc) ->
        case is_meeting_day(Day) of
            true -> Acc;
            false -> Acc + 1
        end
    end, Count, Days).

is_meeting_day(Day) ->
    Day rem 7 == 0.