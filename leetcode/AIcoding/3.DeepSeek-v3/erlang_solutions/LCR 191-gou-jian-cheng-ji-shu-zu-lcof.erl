-spec statistics(Data :: [integer()]) -> [float()].
statistics(Data) ->
    Sum = lists:sum(Data),
    Len = length(Data),
    Mean = Sum / Len,
    Sorted = lists:sort(Data),
    Median = case Len rem 2 of
        1 -> lists:nth((Len div 2) + 1, Sorted);
        0 -> (lists:nth(Len div 2, Sorted) + lists:nth((Len div 2) + 1, Sorted)) / 2
    end,
    Mode = mode(Sorted, 1, 1, lists:nth(1, Sorted), 1, lists:nth(1, Sorted)),
    [Mean, Median, Mode].

mode([], _, MaxCount, _, _, Mode) -> Mode;
mode([H|T], CurrentCount, MaxCount, CurrentNum, _, Mode) when H =:= CurrentNum ->
    mode(T, CurrentCount + 1, MaxCount, CurrentNum, MaxCount, Mode);
mode([H|T], CurrentCount, MaxCount, _, CurrentMax, Mode) when CurrentCount > MaxCount ->
    mode(T, 1, CurrentCount, H, CurrentCount, H);
mode([H|T], CurrentCount, MaxCount, _, CurrentMax, Mode) when CurrentCount =:= MaxCount, H < Mode ->
    mode(T, 1, MaxCount, H, CurrentMax, H);
mode([H|T], _, MaxCount, _, CurrentMax, Mode) ->
    mode(T, 1, MaxCount, H, CurrentMax, Mode).