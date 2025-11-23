-spec merge(Intervals :: [[integer()]]) -> [[integer()]].
merge(Intervals) ->
    Sorted = lists:sort(fun([A, _], [B, _]) -> A =< B end, Intervals),
    merge_intervals(Sorted, []).

merge_intervals([], Acc) ->
    lists:reverse(Acc);
merge_intervals([[Start, End] | Rest], []) ->
    merge_intervals(Rest, [[Start, End]]);
merge_intervals([[Start, End] | Rest], [[PrevStart, PrevEnd] | AccRest]) ->
    if
        Start =< PrevEnd ->
            NewInterval = [PrevStart, max(PrevEnd, End)],
            merge_intervals(Rest, [NewInterval | AccRest]);
        true ->
            merge_intervals(Rest, [[Start, End], [PrevStart, PrevEnd] | AccRest])
    end.