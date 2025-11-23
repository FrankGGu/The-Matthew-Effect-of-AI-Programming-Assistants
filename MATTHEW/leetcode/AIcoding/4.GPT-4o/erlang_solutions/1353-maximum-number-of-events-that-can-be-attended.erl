-module(solution).
-export([max_events/1]).

max_events(Events) ->
    Events1 = lists:sort(fun({Start1, _}, {Start2, _}) -> Start1 < Start2 end, Events),
    max_events_helper(Events1, 0, 0).

max_events_helper([], _, Count) -> 
    Count;
max_events_helper([{Start, End} | Rest], CurrentDay, Count) ->
    NewCurrentDay = if 
        Start > CurrentDay -> Start;
        true -> CurrentDay + 1
    end,
    max_events_helper(Rest, NewCurrentDay, Count + 1).