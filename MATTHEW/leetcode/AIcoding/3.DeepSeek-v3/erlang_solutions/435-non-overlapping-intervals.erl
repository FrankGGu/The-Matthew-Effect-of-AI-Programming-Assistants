-spec erase_overlap_intervals(Intervals :: [[integer()]]) -> integer().
erase_overlap_intervals(Intervals) ->
    Sorted = lists:sort(fun([A, _], [B, _]) -> A =< B end, Intervals),
    Count = count_non_overlapping(Sorted, -inf, 0),
    length(Intervals) - Count.

count_non_overlapping([], _, Count) -> Count;
count_non_overlapping([[Start, End] | Rest], PrevEnd, Count) ->
    if
        Start >= PrevEnd -> count_non_overlapping(Rest, End, Count + 1);
        true -> count_non_overlapping(Rest, min(PrevEnd, End), Count)
    end.

min(A, B) when A =< B -> A;
min(_, B) -> B.