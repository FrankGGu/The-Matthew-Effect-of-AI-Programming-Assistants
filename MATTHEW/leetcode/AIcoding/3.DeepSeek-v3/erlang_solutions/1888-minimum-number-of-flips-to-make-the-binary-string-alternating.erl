-spec min_flips(S :: unicode:unicode_binary()) -> integer().
min_flips(S) ->
    N = byte_size(S),
    S1 = binary_to_list(S),
    S2 = S1 ++ S1,
    Flip1 = flip_count(S2, $0, N),
    Flip2 = flip_count(S2, $1, N),
    min(Flip1, Flip2).

flip_count(S, Start, N) ->
    Flip = 0,
    MinFlip = N,
    flip_count(S, Start, 0, N, Flip, MinFlip).

flip_count(_S, _Expected, Index, N, Flip, MinFlip) when Index >= N * 2 ->
    MinFlip;
flip_count(S, Expected, Index, N, Flip, MinFlip) when Index < N ->
    CurrentFlip = Flip,
    NewMinFlip = MinFlip,
    NewExpected = case Expected of $0 -> $1; $1 -> $0 end,
    flip_count(S, NewExpected, Index + 1, N, CurrentFlip, NewMinFlip);
flip_count(S, Expected, Index, N, Flip, MinFlip) ->
    Char = lists:nth(Index + 1, S),
    NewFlip = if Char =/= Expected -> Flip + 1; true -> Flip end,
    if Index >= N ->
        FirstChar = lists:nth(Index - N + 1, S),
        PrevExpected = case (Index - N) rem 2 of 0 -> $0; 1 -> $1 end,
        AdjustedFlip = if FirstChar =/= PrevExpected -> NewFlip - 1; true -> NewFlip end,
        NewMinFlip = min(AdjustedFlip, MinFlip),
        NewExpected = case Expected of $0 -> $1; $1 -> $0 end,
        flip_count(S, NewExpected, Index + 1, N, AdjustedFlip, NewMinFlip);
    true ->
        NewExpected = case Expected of $0 -> $1; $1 -> $0 end,
        flip_count(S, NewExpected, Index + 1, N, NewFlip, MinFlip)
    end.

min(A, B) when A < B -> A;
min(_A, B) -> B.