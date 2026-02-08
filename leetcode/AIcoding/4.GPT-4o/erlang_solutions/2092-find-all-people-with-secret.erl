-module(solution).
-export([find_all_people/3]).

find_all_people(N, meetings, first_known) ->
    People = lists:duplicate(N + 1, false),
    People = lists:replace(People, 1, true),
    Meetings = lists:map(fun({x, y, time}) -> {time, x, y} end, meetings),
    SortedMeetings = lists:sort(fun({Time1, _, _}, {Time2, _, _}) -> Time1 < Time2 end, Meetings),
    process_meetings(SortedMeetings, People, first_known).

process_meetings([], People, _) -> 
    lists:filter(fun(X) -> lists:nth(X + 1, People) end, lists:seq(0, length(People) - 1));
process_meetings([{Time, X, Y} | Rest], People, FirstKnown) ->
    NewPeople = if
        lists:nth(X + 1, People) orelse lists:nth(Y + 1, People) -> 
            lists:replace(People, X, true),
            lists:replace(People, Y, true);
        true -> People
    end,
    process_meetings(Rest, NewPeople, FirstKnown).