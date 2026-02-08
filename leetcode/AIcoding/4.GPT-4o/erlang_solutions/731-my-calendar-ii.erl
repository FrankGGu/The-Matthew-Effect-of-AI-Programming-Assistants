-module(my_calendar_ii).
-export([MyCalendarII/0]).

-record(event, {start, end}).

MyCalendarII() ->
    Calendar = #calendar{events = []},
    {ok, Calendar}.

add_event(Calendar, Start, End) ->
    case can_book(Calendar, Start, End) of
        true ->
            NewEvent = #event{start = Start, end = End},
            NewEvents = [NewEvent | Calendar#calendar.events],
            {ok, Calendar#calendar{events = NewEvents}};
        false ->
            {error, "Cannot book this event"}
    end.

can_book(Calendar, Start, End) ->
    not lists:any(fun(#{start = S, end = E}) -> 
        (Start < E) andalso (S < End) 
    end, Calendar#calendar.events).