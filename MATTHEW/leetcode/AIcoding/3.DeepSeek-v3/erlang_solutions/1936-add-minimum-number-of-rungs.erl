-spec add_rungs(Rungs :: [integer()], Dist :: integer()) -> integer().
add_rungs(Rungs, Dist) ->
    add_rungs(Rungs, Dist, 0, 0).

add_rungs([], _Dist, Prev, Added) ->
    Added;
add_rungs([H | T], Dist, Prev, Added) ->
    Diff = H - Prev,
    if 
        Diff > Dist ->
            Needed = (Diff - 1) div Dist,
            add_rungs(T, Dist, H, Added + Needed);
        true ->
            add_rungs(T, Dist, H, Added)
    end.