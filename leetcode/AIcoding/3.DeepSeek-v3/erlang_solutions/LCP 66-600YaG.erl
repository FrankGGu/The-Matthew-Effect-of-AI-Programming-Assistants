-spec min_booths([unicode:unicode_binary()]) -> integer().
min_booths(Events) ->
    TimeSlots = lists:flatten([ [ {S, 1}, {E, -1} ] || <<S:8, $-, E:8>> <- Events ]),
    Sorted = lists:keysort(1, TimeSlots),
    {Max, _} = lists:foldl(fun({_, Delta}, {Current, Max}) ->
        NewCurrent = Current + Delta,
        {NewCurrent, erlang:max(NewCurrent, Max)}
    end, {0, 0}, Sorted),
    Max.