-spec min_taps(N :: integer(), Ranges :: [integer()]) -> integer().
min_taps(N, Ranges) ->
    Intervals = lists:map(fun(I) -> 
                            R = lists:nth(I + 1, Ranges),
                            {max(0, I - R), min(N, I + R)}
                          end, lists:seq(0, N)),
    Sorted = lists:sort(fun({A1, B1}, {A2, B2}) -> 
                            A1 =< A2 orelse (A1 == A2 andalso B1 >= B2)
                          end, Intervals),
    min_taps(Sorted, 0, 0, 0).

min_taps([], _, CurrentEnd, Taps) when CurrentEnd >= length(Ranges) - 1 -> Taps;
min_taps([], _, _, _) -> -1;
min_taps([{Start, End} | Rest], LastEnd, CurrentEnd, Taps) when Start > CurrentEnd -> -1;
min_taps([{Start, End} | Rest], LastEnd, CurrentEnd, Taps) when Start =< LastEnd ->
    min_taps(Rest, LastEnd, max(CurrentEnd, End), Taps);
min_taps([{Start, End} | Rest], LastEnd, CurrentEnd, Taps) ->
    min_taps(Rest, CurrentEnd, max(CurrentEnd, End), Taps + 1).