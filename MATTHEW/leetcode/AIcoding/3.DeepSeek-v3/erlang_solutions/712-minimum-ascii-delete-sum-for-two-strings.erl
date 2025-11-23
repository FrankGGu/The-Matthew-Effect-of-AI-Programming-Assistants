-spec minimum_delete_sum(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary()) -> integer().
minimum_delete_sum(S1, S2) ->
    S1List = unicode:characters_to_list(S1),
    S2List = unicode:characters_to_list(S2),
    M = length(S1List),
    N = length(S2List),
    DP = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    DP1 = init_dp(DP, S1List, S2List, M, N),
    calculate_dp(DP1, S1List, S2List, M, N).

init_dp(DP, S1, S2, M, N) ->
    DP1 = init_first_row(DP, S2, 1, N),
    init_first_col(DP1, S1, 1, M).

init_first_row(DP, S2, J, N) when J > N ->
    DP;
init_first_row(DP, S2, J, N) ->
    Char = lists:nth(J, S2),
    Prev = lists:nth(1, lists:nth(J, DP)),
    NewVal = Prev + Char,
    NewRow = set_dp(DP, 1, J + 1, NewVal),
    init_first_row(NewRow, S2, J + 1, N).

init_first_col(DP, S1, I, M) when I > M ->
    DP;
init_first_col(DP, S1, I, M) ->
    Char = lists:nth(I, S1),
    Prev = lists:nth(1, lists:nth(I, DP)),
    NewVal = Prev + Char,
    NewRow = set_dp(DP, I + 1, 1, NewVal),
    init_first_col(NewRow, S1, I + 1, M).

calculate_dp(DP, S1, S2, M, N) ->
    calculate_dp(DP, S1, S2, 1, 1, M, N).

calculate_dp(DP, S1, S2, I, J, M, N) when I > M; J > N ->
    lists:nth(M + 1, lists:nth(N + 1, DP));
calculate_dp(DP, S1, S2, I, J, M, N) ->
    Char1 = lists:nth(I, S1),
    Char2 = lists:nth(J, S2),
    if
        Char1 == Char2 ->
            Prev = lists:nth(I, lists:nth(J, DP)),
            NewDP = set_dp(DP, I + 1, J + 1, Prev),
            calculate_dp(NewDP, S1, S2, I + 1, J + 1, M, N);
        true ->
            Up = lists:nth(I, lists:nth(J + 1, DP)) + Char1,
            Left = lists:nth(I + 1, lists:nth(J, DP)) + Char2,
            NewVal = min(Up, Left),
            NewDP = set_dp(DP, I + 1, J + 1, NewVal),
            calculate_dp(NewDP, S1, S2, I, J + 1, M, N)
    end.

set_dp(DP, I, J, Val) ->
    Row = lists:nth(I, DP),
    NewRow = setnth(J, Val, Row),
    setnth(I, NewRow, DP).

setnth(1, Val, [_|T]) -> [Val|T];
setnth(N, Val, [H|T]) -> [H|setnth(N - 1, Val, T)].