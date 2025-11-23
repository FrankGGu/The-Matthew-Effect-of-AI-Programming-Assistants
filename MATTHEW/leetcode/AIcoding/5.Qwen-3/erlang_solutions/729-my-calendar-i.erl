-module(my_calendar_i).
-export([book/2]).

book(Start, End) ->
    case ets:lookup(?MODULE, {Start, End}) of
        [] ->
            ets:insert(?MODULE, {{Start, End}, true}),
            true;
        _ ->
            false
    end.

init() ->
    ets:new(?MODULE, [named_table, public, {write_concurrency, true}]).

-define(MODULE, my_calendar_i).