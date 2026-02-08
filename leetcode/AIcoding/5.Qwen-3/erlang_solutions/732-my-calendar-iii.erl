-module(my_calendar_iii).
-export([book/2]).

-record(calendar, {events = []}).

book(Start, End) ->
    State = #calendar{},
    {NewState, Result} = update(State, Start, End),
    Result.

update(#calendar{events = Events} = State, Start, End) ->
    SortedEvents = lists:sort(Events ++ [{Start, 1}, {End, -1}]),
    MaxCount = calculate_max(SortedEvents, 0, 0),
    {State#calendar{events = SortedEvents}, MaxCount}.

calculate_max([], _Current, Max) ->
    Max;
calculate_max([{Pos, Delta} | Rest], Current, Max) ->
    NewCurrent = Current + Delta,
    NewMax = max(Max, NewCurrent),
    calculate_max(Rest, NewCurrent, NewMax).