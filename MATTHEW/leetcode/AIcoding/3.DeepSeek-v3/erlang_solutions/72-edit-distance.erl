-spec min_distance(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> integer().
min_distance(Word1, Word2) ->
    M = byte_size(Word1),
    N = byte_size(Word2),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    DP1 = init_dp(DP, M, N),
    DP2 = fill_dp(DP1, Word1, Word2, 1, 1),
    lists:nth(M + 1, lists:nth(N + 1, DP2)).

init_dp(DP, M, N) ->
    DP1 = init_row(DP, 0, M),
    init_col(DP1, 0, N).

init_row(DP, J, M) ->
    lists:foldl(fun(I, Acc) -> 
        Row = lists:nth(I + 1, Acc),
        NewRow = setnth(J + 1, I, Row),
        setnth(I + 1, NewRow, Acc)
    end, DP, lists:seq(1, M)).

init_col(DP, I, N) ->
    lists:foldl(fun(J, Acc) -> 
        Row = lists:nth(I + 1, Acc),
        NewRow = setnth(J + 1, J, Row),
        setnth(I + 1, NewRow, Acc)
    end, DP, lists:seq(1, N)).

fill_dp(DP, Word1, Word2, I, J) when I =< byte_size(Word1), J =< byte_size(Word2) ->
    Char1 = binary:at(Word1, I - 1),
    Char2 = binary:at(Word2, J - 1),
    PrevRow = lists:nth(I, DP),
    PrevCol = lists:nth(J, lists:nth(I + 1, DP)),
    PrevBoth = lists:nth(J, PrevRow),
    Cost = if Char1 =:= Char2 -> 0; true -> 1 end,
    Val = min(PrevBoth + Cost, min(PrevRow + 1, PrevCol + 1)),
    Row = lists:nth(I + 1, DP),
    NewRow = setnth(J + 1, Val, Row),
    NewDP = setnth(I + 1, NewRow, DP),
    if
        J < byte_size(Word2) -> fill_dp(NewDP, Word1, Word2, I, J + 1);
        I < byte_size(Word1) -> fill_dp(NewDP, Word1, Word2, I + 1, 1);
        true -> NewDP
    end;
fill_dp(DP, _, _, _, _) -> DP.

setnth(1, X, [_|T]) -> [X|T];
setnth(N, X, [H|T]) -> [H|setnth(N-1, X, T)].

min(A, B) when A < B -> A;
min(_, B) -> B.