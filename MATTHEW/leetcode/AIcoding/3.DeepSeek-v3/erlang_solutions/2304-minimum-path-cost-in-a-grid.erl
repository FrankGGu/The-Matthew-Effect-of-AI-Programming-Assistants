-spec min_path_cost(Grid :: [[integer()]], MoveCost :: [[integer()]]) -> integer().
min_path_cost(Grid, MoveCost) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M, lists:duplicate(N, 0)),
    DP1 = lists:zipwith(fun(Row, DPRow) ->
        lists:zipwith(fun(Val, _) -> Val end, Row, DPRow)
    end, Grid, DP),
    DP2 = solve(1, M, N, DP1, Grid, MoveCost),
    lists:min(lists:last(DP2)).

solve(I, M, _, DP, _, _) when I >= M -> DP;
solve(I, M, N, DP, Grid, MoveCost) ->
    NewDP = update_row(I, N, DP, Grid, MoveCost),
    solve(I + 1, M, N, NewDP, Grid, MoveCost).

update_row(I, N, DP, Grid, MoveCost) ->
    Row = lists:nth(I + 1, Grid),
    PrevRow = lists:nth(I, DP),
    NewRow = lists:map(fun(J) ->
        Val = lists:nth(J + 1, Row),
        lists:min(lists:map(fun(K) ->
            PrevVal = lists:nth(K + 1, PrevRow),
            Cost = lists:nth(lists:nth(I, Grid) + 1, lists:nth(K + 1, MoveCost)),
            PrevVal + Cost + Val
        end, lists:seq(0, N - 1)))
    end, lists:seq(0, N - 1)),
    lists:sublist(DP, I) ++ [NewRow] ++ lists:nthtail(I + 1, DP).