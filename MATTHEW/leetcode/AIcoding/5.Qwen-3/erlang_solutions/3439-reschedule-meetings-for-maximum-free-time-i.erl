-module(reschedule_meetings_for_maximum_free_time_i).
-export([max_free_time/1]).

max_free_time(Meetings) ->
    Sorted = lists:sort(Meetings),
    find_max_free(Sorted, 0, 0).

find_max_free([], _, Max) ->
    Max;
find_max_free([[Start1, End1] | [Start2, End2] | Rest], CurrentMax, _) when Start2 > End1 ->
    FreeTime = Start2 - End1,
    find_max_free([Start2, End2] ++ Rest, CurrentMax, FreeTime);
find_max_free([[Start1, End1] | [Start2, End2] | Rest], CurrentMax, _) when Start2 =< End1 ->
    find_max_free([Start2, End2] ++ Rest, CurrentMax, CurrentMax);
find_max_free([[Start, End] | Rest], CurrentMax, _) ->
    find_max_free(Rest, CurrentMax, CurrentMax).