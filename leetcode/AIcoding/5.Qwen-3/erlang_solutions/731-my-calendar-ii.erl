-module(my_calendar_ii).
-export([book/2]).

-record(calendar, {events = []}).

book(Start, End) ->
    State = #calendar{},
    book(Start, End, State).

book(Start, End, #calendar{events = Events} = State) ->
    Overlaps = lists:filter(fun(Event) -> not (End =< Event#event.start orelse Start >= Event#event.end) end, Events),
    case check_double_overlap(Overlaps) of
        true ->
            false;
        false ->
            NewEvents = [#{start => Start, end => End} | Events],
            State#calendar{events = NewEvents},
            true
    end.

check_double_overlap([]) ->
    false;
check_double_overlap([H | T]) ->
    lists:member(H, T) orelse check_double_overlap(T).