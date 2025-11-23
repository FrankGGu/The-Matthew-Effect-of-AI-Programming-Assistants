-spec max_chunks_to_sorted(Arr :: [integer()]) -> integer().
max_chunks_to_sorted(Arr) ->
    Max = 0,
    Chunks = 0,
    max_chunks_to_sorted(Arr, 0, 0, 0).

max_chunks_to_sorted([], _Max, _I, Chunks) ->
    Chunks;
max_chunks_to_sorted([H | T], Max, I, Chunks) ->
    NewMax = max(H, Max),
    if
        NewMax == I ->
            max_chunks_to_sorted(T, NewMax, I + 1, Chunks + 1);
        true ->
            max_chunks_to_sorted(T, NewMax, I + 1, Chunks)
    end.