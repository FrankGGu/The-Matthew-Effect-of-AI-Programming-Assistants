-module(my_calendar).
-export([new/0, book/3]).

-record(calendar, {events = []}).

new() ->
    #calendar{}.

book(Calendar, start, end) ->
    case can_book(Calendar#calendar.events, start, end) of
        true ->
            NewEvents = [{start, end} | Calendar#calendar.events],
            {ok, #calendar{events = NewEvents}};
        false ->
            {error, already_booked}
    end.

can_book([], _Start, _End) ->
    true;
can_book([{S, E} | Rest], Start, End) ->
    if
        Start >= E orelse End <= S ->
            can_book(Rest, Start, End);
        true ->
            false
    end.