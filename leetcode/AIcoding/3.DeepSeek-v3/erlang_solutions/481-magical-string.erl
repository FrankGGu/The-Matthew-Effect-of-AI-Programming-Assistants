-spec magical_string(N :: integer()) -> integer().
magical_string(N) ->
    if
        N =:= 0 -> 0;
        N =< 3 -> 1;
        true ->
            magical_string(N, [1, 2, 2], [1, 2, 2], 3, 2)
    end.

magical_string(N, S, _OrigS, Len, Count) when Len >= N ->
    Count;
magical_string(N, [H | T], OrigS, Len, Count) ->
    NewElems = lists:duplicate(H, case lists:last(OrigS) of 1 -> 2; 2 -> 1 end),
    NewS = T ++ NewElems,
    NewOrigS = OrigS ++ NewElems,
    NewLen = Len + H,
    NewCount = if
        H =:= 1 -> Count + min(H, N - Len);
        true -> Count
    end,
    magical_string(N, NewS, NewOrigS, NewLen, NewCount).