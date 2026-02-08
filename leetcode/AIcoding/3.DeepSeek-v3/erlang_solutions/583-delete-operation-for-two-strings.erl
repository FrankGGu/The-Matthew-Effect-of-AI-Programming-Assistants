-spec min_distance(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> integer().
min_distance(Word1, Word2) ->
    W1 = binary_to_list(Word1),
    W2 = binary_to_list(Word2),
    M = length(W1),
    N = length(W2),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    DP1 = init_dp(DP, M, N),
    DP2 = fill_dp(DP1, W1, W2, 1, 1),
    LCS = lists:nth(M + 1, lists:nth(N + 1, DP2)),
    (M - LCS) + (N - LCS).

init_dp(DP, M, N) ->
    init_dp(DP, 0, M, N).

init_dp(DP, I, M, N) when I =< M ->
    Row = lists:nth(I + 1, DP),
    NewRow = lists:keyreplace(1, 1, Row, {1, 0}),
    NewDP = lists:keyreplace(I + 1, 1, DP, {I + 1, NewRow}),
    init_dp(NewDP, I + 1, M, N);
init_dp(DP, _, _, _) -> DP.

fill_dp(DP, W1, W2, I, J) when I =< length(W1), J =< length(W2) ->
    Char1 = lists:nth(I, W1),
    Char2 = lists:nth(J, W2),
    PrevRow = lists:nth(I, DP),
    PrevCol = lists:nth(J, lists:nth(I + 1, DP)),
    PrevBoth = lists:nth(J, lists:nth(I, DP)),
    if
        Char1 =:= Char2 ->
            NewVal = PrevBoth + 1;
        true ->
            NewVal = max(PrevCol, lists:nth(J + 1, PrevRow))
    end,
    Row = lists:nth(I + 1, DP),
    NewRow = lists:keyreplace(J + 1, 1, Row, {J + 1, NewVal}),
    NewDP = lists:keyreplace(I + 1, 1, DP, {I + 1, NewRow}),
    if
        J =:= length(W2) ->
            fill_dp(NewDP, W1, W2, I + 1, 1);
        true ->
            fill_dp(NewDP, W1, W2, I, J + 1)
    end;
fill_dp(DP, _, _, _, _) -> DP.