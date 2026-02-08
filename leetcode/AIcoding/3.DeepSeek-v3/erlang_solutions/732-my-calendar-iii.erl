-module(my_calendar_iii).
-export([book/3, init/0]).

-record(calendar, {events = []}).

init() ->
    #calendar{}.

book(Start, End, #calendar{events = Events} = Cal) ->
    NewEvents = lists:merge(Events, [{Start, 1}, {End, -1}]),
    Sorted = lists:keysort(1, NewEvents),
    {Max, _} = lists:foldl(fun({_, Delta}, {Current, Max}) ->
        NewCurrent = Current + Delta,
        {NewCurrent, max(Max, NewCurrent)}
    end, {0, 0}, Sorted),
    {Max, Cal#calendar{events = Sorted}}.