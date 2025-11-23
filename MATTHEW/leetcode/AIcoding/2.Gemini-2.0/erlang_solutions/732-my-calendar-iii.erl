-module(my_calendar_iii).
-export([new/0, book/2]).

-record(state, {events = []}).

new() ->
    #state{}.

book(#state{events = Events}, Start, End) ->
    NewEvents = insert_event(Events, Start, End, 0),
    {max_overlap(NewEvents, 0), #state{events = NewEvents}}.

insert_event(Events, Start, End, Overlap) ->
    case Events of
        [] ->
            [{Start, 1}, {End, -1}];
        [{EventStart, Count} | Rest] ->
            if Start < EventStart then
                [{Start, 1} | insert_event([{EventStart, Count} | Rest], Start, End, Overlap)];
            else
                case lists:keyfind(Start, 1, Events) of
                    false ->
                        [{EventStart, Count} | insert_event(Rest, Start, End, Overlap)];
                    _ ->
                        insert_event(Rest, Start, End, Overlap)
                end
            end,
            case lists:keyfind(End, 1, Events) of
                false ->
                    case lists:keyfind(End, 1, insert_event(Events, Start, End, Overlap)) of
                        false ->
                            insert_end_event(insert_event(Events, Start, End, Overlap), End);
                        _ ->
                            insert_event(Events, Start, End, Overlap)
                    end;
                _ ->
                    insert_event(Events, Start, End, Overlap)
            end
    end.

insert_end_event(Events, End) ->
    lists:sort(Events ++ [{End, -1}]).

max_overlap(Events, MaxOverlap) ->
    max_overlap(Events, 0, 0, MaxOverlap).

max_overlap([], _, Max, Max).

max_overlap([{_, Change} | Rest], Current, Max, MaxOverlap) ->
    NewCurrent = Current + Change,
    NewMax = max(Max, NewCurrent),
    max_overlap(Rest, NewCurrent, NewMax, max(NewMax, MaxOverlap)).

max(A, B) ->
    if A > B then
        A
    else
        B
    end.