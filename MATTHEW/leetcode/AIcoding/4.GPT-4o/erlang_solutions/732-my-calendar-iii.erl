-module(my_calendar_iii).
-export([MyCalendarIII/0]).

-record(event, {start, end, count}).

MyCalendarIII() ->
    Calendar = fun() -> 
        {ok, Calendar} = ets:new(calendar, [named_table, public, {keypos, 1}]),
        {Calendar, []}
    end,
    fun add_event(Start, End) ->
        {Calendar, Events} = Calendar(),
        ets:insert(Calendar, {Start, End}),
        NewEvents = [{Start, End} | Events],
        {Calendar, NewEvents}
    end,
    fun query() ->
        {Calendar, Events} = Calendar(),
        lists:foldl(fun({Start, End}, Acc) -> 
            MaxCount = lists:max([Count || {_, _, Count} <- Acc]),
            [{Start, End, MaxCount + 1} | Acc]
        end, [], Events)
    end,
    {add_event, query}.