-spec maximum_gap(Nums :: [integer()]) -> integer().
maximum_gap([_]) -> 0;
maximum_gap(Nums) ->
    Sorted = lists:sort(Nums),
    maximum_gap(Sorted, 0, hd(Sorted), 0).

maximum_gap([], Max, _, Max) -> Max;
maximum_gap([H | T], Prev, MaxSoFar, Acc) ->
    NewMax = max(MaxSoFar, H - Prev),
    maximum_gap(T, H, NewMax, Acc).
