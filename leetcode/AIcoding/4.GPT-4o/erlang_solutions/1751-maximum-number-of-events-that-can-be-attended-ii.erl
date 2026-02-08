-module(solution).
-export([max_events/2]).

max_events(Events, k) ->
    Events1 = lists:sort(fun({Start1, End1, _}, {Start2, End2, _}) -> 
        case Start1 =< Start2 of
            true -> true;
            false -> false
        end
    end, Events),
    max_events_helper(Events1, k, 0, 0).

max_events_helper([], _, _, Count) -> Count;
max_events_helper(Events, 0, _, Count) -> Count;
max_events_helper([{Start, End, Value} | Rest], k, LastEnd, Count) when Start > LastEnd ->
    max_events_helper(Rest, k - 1, End, Count + Value);
max_events_helper([_ | Rest], k, LastEnd, Count) ->
    max_events_helper(Rest, k, LastEnd, Count).