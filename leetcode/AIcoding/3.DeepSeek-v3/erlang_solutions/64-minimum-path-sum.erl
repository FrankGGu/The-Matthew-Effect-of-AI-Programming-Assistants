-spec min_path_sum(Grid :: [[integer()]]) -> integer().
min_path_sum(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M, lists:duplicate(N, 0)),
    DP1 = update_dp(1, 1, M, N, Grid, DP),
    lists:nth(M, lists:nth(N, DP1)).

update_dp(I, J, M, N, Grid, DP) when I > M orelse J > N ->
    DP;
update_dp(I, J, M, N, Grid, DP) ->
    Val = lists:nth(I, lists:nth(J, Grid)),
    UpdatedDP = case {I, J} of
        {1, 1} -> set_dp(I, J, Val, DP);
        {1, _} -> 
            Prev = lists:nth(I, lists:nth(J - 1, DP)),
            set_dp(I, J, Prev + Val, DP);
        {_, 1} -> 
            Prev = lists:nth(I - 1, lists:nth(J, DP)),
            set_dp(I, J, Prev + Val, DP);
        _ ->
            Left = lists:nth(I, lists:nth(J - 1, DP)),
            Up = lists:nth(I - 1, lists:nth(J, DP)),
            set_dp(I, J, min(Left, Up) + Val, DP)
    end,
    NextI = if J =:= N -> I + 1; true -> I end,
    NextJ = if J =:= N -> 1; true -> J + 1 end,
    update_dp(NextI, NextJ, M, N, Grid, UpdatedDP).

set_dp(I, J, Val, DP) ->
    Row = lists:nth(I, DP),
    UpdatedRow = setnth(J, Val, Row),
    setnth(I, UpdatedRow, DP).

setnth(1, Val, [_|T]) -> [Val|T];
setnth(N, Val, [H|T]) -> [H|setnth(N - 1, Val, T)].