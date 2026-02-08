-module(my_calendar_i).
-export([MyCalendar_init/0, book/2]).

-record(calendar, {events = []}).

MyCalendar_init() ->
    #calendar{}.

book(Cal, Start, End) ->
    case lists:any(fun({S, E}) -> Start < E andalso S < End end, Cal#calendar.events) of
        true -> false;
        false -> 
            NewEvents = [{Start, End} | Cal#calendar.events],
            {true, Cal#calendar{events = NewEvents}}
    end.