-record(interval, {start, end}).

-module(my_calendar).
-export([init/0, book/2]).

init() ->
    [].

book(Start, End, Calendar) ->
    case can_book(Start, End, Calendar) of
        true -> {true, Calendar ++ [#interval{start=Start, end=End}]};
        false -> {false, Calendar}
    end.

can_book(Start, End, []) ->
    true;
can_book(Start, End, [#interval{start=S, end=E} | Rest]) ->
    if
        End =< S -> can_book(Start, End, Rest);
        Start >= E -> can_book(Start, End, Rest);
        true -> false
    end.