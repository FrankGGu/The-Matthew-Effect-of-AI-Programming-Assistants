-spec find_peaks(Mountain :: [integer()]) -> [integer()].
find_peaks(Mountain) ->
    find_peaks(Mountain, 1, length(Mountain) - 1, []).

find_peaks([_], _Index, _Len, Acc) -> lists:reverse(Acc);
find_peaks([A, B, C | Rest], Index, Len, Acc) ->
    NewAcc = if
        (B > A) and (B > C) -> [Index | Acc];
        true -> Acc
    end,
    find_peaks([B, C | Rest], Index + 1, Len, NewAcc);
find_peaks(_, _Index, _Len, Acc) -> lists:reverse(Acc).