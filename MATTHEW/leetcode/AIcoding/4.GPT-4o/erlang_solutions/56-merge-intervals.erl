-spec merge(Intervals :: [[integer()]]) -> [[integer()]].
merge(Intervals) ->
    SortedIntervals = lists:sort(fun({Start1, _End1}, {Start2, _End2}) -> Start1 < Start2 end, Intervals),
    merge_intervals(SortedIntervals, []).

merge_intervals([], Acc) -> lists:reverse(Acc);
merge_intervals([Current | Rest], []) -> merge_intervals(Rest, [Current]);
merge_intervals([{Start1, End1} | Rest], [{Start2, End2} | Acc]) when Start1 <= End2 ->
    merge_intervals(Rest, [{Start2, max(End1, End2)} | Acc]);
merge_intervals([Current | Rest], Acc) -> merge_intervals(Rest, [Current | Acc]).
