-spec binary_gap(N :: integer()) -> integer().
binary_gap(N) ->
    binary_gap(N bsr 1, N band 1, 0, 0).

binary_gap(0, _, _, Max) -> Max;
binary_gap(N, LastBit, Current, Max) ->
    CurrentBit = N band 1,
    if
        LastBit == 1 andalso CurrentBit == 0 ->
            binary_gap(N bsr 1, CurrentBit, Current + 1, Max);
        CurrentBit == 1 andalso Current > 0 ->
            binary_gap(N bsr 1, CurrentBit, 0, max(Current, Max));
        true ->
            binary_gap(N bsr 1, CurrentBit, Current, Max)
    end.