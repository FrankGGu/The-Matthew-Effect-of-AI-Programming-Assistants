-spec max_events(Events :: [[integer()]]) -> integer().
max_events(Events) ->
    SortedEvents = lists:sort(fun([S1, _], [S2, _]) -> S1 =< S2 end, Events),
    max_events(SortedEvents, 1, 0).

max_events([], _Day, Count) -> Count;
max_events(Events, Day, Count) ->
    case lists:partition(fun([S, E]) -> S =< Day andalso Day =< E end, Events) do
        {[], Rest} ->
            max_events(Rest, Day + 1, Count);
        {Available, Rest} ->
            Selected = lists:min(fun([_, E1], [_, E2]) -> E1 =< E2 end, Available),
            NewRest = lists:delete(Selected, Available) ++ Rest,
            max_events(NewRest, Day + 1, Count + 1)
    end.