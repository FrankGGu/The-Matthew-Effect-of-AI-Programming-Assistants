-record(event, {start, end}).

init_() ->
    [].

book(Start, End, Calendar) ->
    case can_book(Start, End, Calendar) of
        true -> {true, [#event{start=Start, end=End} | Calendar]};
        false -> {false, Calendar}
    end.

can_book(Start, End, []) -> true;
can_book(Start, End, [Event | Rest]) ->
    if
        Start >= Event#event.end -> can_book(Start, End, Rest);
        End =< Event#event.start -> can_book(Start, End, Rest);
        true -> false
    end.