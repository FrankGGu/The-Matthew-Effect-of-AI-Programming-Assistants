-spec merge(Intervals :: [[integer()]]) -> [[integer()]].
merge(Intervals) ->
    Sorted = lists:sort(fun([A, _], [B, _]) -> A =< B end, Intervals),
    merge_intervals(Sorted, []).

merge_intervals([], Acc) ->
    lists:reverse(Acc);
merge_intervals([[S1, E1] | Rest], []) ->
    merge_intervals(Rest, [[S1, E1]]);
merge_intervals([[S1, E1] | Rest], [[S2, E2] | AccRest]) ->
    if
        S1 =< E2 ->
            NewInterval = [S2, max(E1, E2)],
            merge_intervals(Rest, [NewInterval | AccRest]);
        true ->
            merge_intervals(Rest, [[S1, E1], [S2, E2] | AccRest])
    end.