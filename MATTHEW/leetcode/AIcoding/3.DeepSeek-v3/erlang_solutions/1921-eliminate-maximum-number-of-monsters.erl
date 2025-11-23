-spec eliminate_maximum(Dist :: [integer()], Speed :: [integer()]) -> integer().
eliminate_maximum(Dist, Speed) ->
    N = length(Dist),
    Time = lists:zipwith(fun(D, S) -> (D - 1) div S end, Dist, Speed),
    SortedTime = lists:sort(Time),
    count_monsters(SortedTime, 0).

count_monsters([], Count) -> Count;
count_monsters([H | T], Count) ->
    if
        H < Count -> Count;
        true -> count_monsters(T, Count + 1)
    end.