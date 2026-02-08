-module(max_events).
-export([max_events/1]).

max_events(Events) ->
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A < B end, Events),
    List = lists:foldl(fun({S, E}, Acc) -> [lists:seq(S, E) | Acc] end, [], Sorted),
    Lists = lists:reverse(List),
    max_events(Lists, 0, 0).

max_events([], _, Count) ->
    Count;
max_events([H | T], Last, Count) ->
    case lists:member(Last, H) of
        true ->
            max_events(T, Last, Count);
        false ->
            Next = lists:filter(fun(X) -> X > Last end, H),
            if
                Next /= [] ->
                    NewLast = lists:nth(1, Next),
                    max_events(T, NewLast, Count + 1);
                true ->
                    max_events(T, Last, Count)
            end
    end.