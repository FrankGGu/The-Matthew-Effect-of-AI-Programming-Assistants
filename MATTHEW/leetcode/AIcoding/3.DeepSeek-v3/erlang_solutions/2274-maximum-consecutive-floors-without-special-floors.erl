-spec max_consecutive(Bottom :: integer(), Top :: integer(), Special :: [integer()]) -> integer().
max_consecutive(Bottom, Top, Special) ->
    Sorted = lists:sort(Special),
    Max = lists:foldl(fun(Floor, {Prev, MaxGap}) ->
        CurrentGap = Floor - Prev - 1,
        NewMaxGap = max(MaxGap, CurrentGap),
        {Floor, NewMaxGap}
    end, {Bottom - 1, 0}, Sorted),
    {_, MaxGap} = Max,
    LastGap = Top - lists:last(Sorted),
    max(MaxGap, LastGap).