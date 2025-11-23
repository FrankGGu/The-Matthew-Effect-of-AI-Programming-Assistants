-record(event, {start, end}).

-record(my_calendar_two, {
    events = [] :: list(#event{}),
    overlaps = [] :: list(#event{})
}).

-spec init_() -> any().
init_() ->
    #my_calendar_two{}.

-spec book(Start :: integer(), End :: integer(), Obj :: any()) -> boolean().
book(Start, End, #my_calendar_two{events = Events, overlaps = Overlaps} = Obj) ->
    case check_overlap(Start, End, Overlaps) of
        true -> false;
        false ->
            NewOverlaps = find_overlaps(Start, End, Events),
            NewEvents = [#event{start = Start, end = End} | Events],
            {ok, Obj#my_calendar_two{events = NewEvents, overlaps = NewOverlaps ++ Overlaps}}
    end.

check_overlap(Start, End, Overlaps) ->
    lists:any(fun(#event{start = S, end = E}) ->
        Start < E andalso End > S
    end, Overlaps).

find_overlaps(Start, End, Events) ->
    lists:filtermap(fun(#event{start = S, end = E}) ->
        case Start < E andalso End > S of
            true -> {true, #event{start = max(Start, S), end = min(End, E)}};
            false -> false
        end
    end, Events).

max(A, B) when A > B -> A;
max(_, B) -> B.

min(A, B) when A < B -> A;
min(_, B) -> B.