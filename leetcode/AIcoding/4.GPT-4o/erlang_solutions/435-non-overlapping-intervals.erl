-module(solution).
-export([erase_overlap_intervals/1]).

-spec erase_overlap_intervals(Intervals :: [[integer()]]) -> integer().
erase_overlap_intervals(Intervals) ->
    Sorted = lists:sort(fun([S1, E1], [S2, E2]) -> E1 < E2 end, Intervals),
    erase_overlap_intervals(Sorted, -1000000000, 0).

-spec erase_overlap_intervals([[integer()]], integer(), integer()) -> integer().
erase_overlap_intervals([], _End, Count) ->
    Count;
erase_overlap_intervals([[Start, End] | Rest], PrevEnd, Count) ->
    if
        Start >= PrevEnd ->
            erase_overlap_intervals(Rest, End, Count);
        true ->
            erase_overlap_intervals(Rest, PrevEnd, Count + 1)
    end.
