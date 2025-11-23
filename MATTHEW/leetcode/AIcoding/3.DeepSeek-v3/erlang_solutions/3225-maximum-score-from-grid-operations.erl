-module(solution).
-export([max_score/1]).

max_score(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M, lists:duplicate(N, -1)),
    {Score, _} = dfs(Grid, 0, 0, DP),
    Score.

dfs(Grid, I, J, DP) ->
    M = length(Grid),
    N = length(hd(Grid)),
    if
        I =:= M - 1 andalso J =:= N - 1 ->
            {0, Grid};
        DP /= -1 ->
            {DP, Grid};
        true ->
            RightScore = if
                J + 1 < N ->
                    {RS, NewGrid1} = move(Grid, I, J, I, J + 1),
                    {SubScore1, _} = dfs(NewGrid1, I, J + 1, DP),
                    RS + SubScore1;
                true ->
                    -1
            end,
            DownScore = if
                I + 1 < M ->
                    {DS, NewGrid2} = move(Grid, I, J, I + 1, J),
                    {SubScore2, _} = dfs(NewGrid2, I + 1, J, DP),
                    DS + SubScore2;
                true ->
                    -1
            end,
            MaxScore = max(RightScore, DownScore),
            NewDP = set_dp(DP, I, J, MaxScore),
            {MaxScore, NewDP}
    end.

move(Grid, I1, J1, I2, J2) ->
    Row1 = lists:nth(I1 + 1, Grid),
    Val1 = lists:nth(J1 + 1, Row1),
    Row2 = lists:nth(I2 + 1, Grid),
    Val2 = lists:nth(J2 + 1, Row2),
    NewRow1 = setelement(J1 + 1, list_to_tuple(Row1), 0),
    NewRow2 = setelement(J2 + 1, list_to_tuple(Row2), Val1 + Val2),
    NewGrid = lists:sublist(Grid, I1) ++ [tuple_to_list(NewRow1)] ++
              lists:sublist(Grid, I1 + 2, M - I1 - 1),
    NewGrid2 = lists:sublist(NewGrid, I2) ++ [tuple_to_list(NewRow2)] ++
               lists:sublist(NewGrid, I2 + 2, M - I2 - 1),
    {Val1 * Val2, NewGrid2}.

set_dp(DP, I, J, Val) ->
    Row = lists:nth(I + 1, DP),
    NewRow = setelement(J + 1, list_to_tuple(Row), Val),
    lists:sublist(DP, I) ++ [tuple_to_list(NewRow)] ++ lists:sublist(DP, I + 2, length(DP) - I - 1).