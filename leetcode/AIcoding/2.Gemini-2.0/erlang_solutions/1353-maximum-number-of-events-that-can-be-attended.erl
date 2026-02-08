-module(max_events).
-export([max_events/1]).

max_events(Events) ->
    max_events_helper(lists:sort(fun({S1, _}, {S2, _}) -> S1 < S2 end, Events), []).

max_events_helper([], _Attending) ->
    0;
max_events_helper([{Start, End} | Rest], Attending) ->
    Attending1 = lists:filter(fun(E) -> E >= Start end, Attending),
    case lists:all(fun(E) -> E > End end, Attending1) of
        true ->
            1 + max_events_helper(Rest, lists:sort([End | Attending1]));
        false ->
            max_events_helper(Rest, Attending1)
    end.