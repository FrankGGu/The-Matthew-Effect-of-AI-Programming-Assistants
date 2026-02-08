-module(solution).
-export([cherry_pickup/1]).

cherry_pickup(Grid) ->
    N = length(Grid),
    DP = lists:duplicate(N, lists:duplicate(N, -1)),
    DP1 = setelement(1, setelement(1, DP, 0), 0),
    Max = cherry_pickup(Grid, DP1, N),
    max(0, Max).

cherry_pickup(Grid, DP, N) ->
    NewDP = lists:duplicate(N, lists:duplicate(N, -1)),
    Updated = update_dp(Grid, DP, NewDP, N, 0, 0),
    case Updated of
        [] -> -1;
        _ -> lists:max([lists:max(Row) || Row <- Updated])
    end.

update_dp(Grid, DP, NewDP, N, I, J) when I < N ->
    Row = lists:nth(I + 1, Grid),
    NewDP1 = update_row(Grid, DP, NewDP, N, I, J, Row),
    update_dp(Grid, DP, NewDP1, N, I + 1, J);
update_dp(_, _, NewDP, _, _, _) -> NewDP.

update_row(Grid, DP, NewDP, N, I, J, Row) when J < N ->
    case lists:nth(J + 1, Row) of
        -1 ->
            NewDP1 = setelement(I + 1, NewDP, setelement(J + 1, lists:nth(I + 1, NewDP), -1)),
            update_row(Grid, DP, NewDP1, N, I, J + 1, Row);
        _ ->
            Max = get_max(DP, I, J, N),
            if
                Max >= 0 ->
                    Val = Max + lists:nth(J + 1, Row),
                    NewDP1 = setelement(I + 1, NewDP, setelement(J + 1, lists:nth(I + 1, NewDP), Val)),
                    update_row(Grid, DP, NewDP1, N, I, J + 1, Row);
                true ->
                    NewDP1 = setelement(I + 1, NewDP, setelement(J + 1, lists:nth(I + 1, NewDP), -1)),
                    update_row(Grid, DP, NewDP1, N, I, J + 1, Row)
            end
    end;
update_row(_, _, NewDP, _, _, _, _) -> NewDP.

get_max(DP, I, J, N) ->
    Candidates = [],
    Candidates1 = if
        I > 0 -> [lists:nth(J + 1, lists:nth(I, DP)) | Candidates];
        true -> Candidates
    end,
    Candidates2 = if
        J > 0 -> [lists:nth(J, lists:nth(I + 1, DP)) | Candidates1];
        true -> Candidates1
    end,
    Candidates3 = if
        I > 0 andalso J > 0 -> [lists:nth(J, lists:nth(I, DP)) | Candidates2];
        true -> Candidates2
    end,
    case Candidates3 of
        [] -> -1;
        _ -> lists:max(Candidates3)
    end.