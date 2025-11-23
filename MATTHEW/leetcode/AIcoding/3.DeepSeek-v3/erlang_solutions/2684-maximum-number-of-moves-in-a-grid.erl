-spec max_moves(Grid :: [[integer()]]) -> integer().
max_moves(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M, lists:duplicate(N, 0)),
    Max = lists:max([max_moves(Grid, DP, I, 0) || I <- lists:seq(0, M - 1)]),
    Max.

max_moves(Grid, DP, I, J) ->
    M = length(Grid),
    N = length(hd(Grid)),
    if
        J =:= N - 1 -> 0;
        true ->
            case lists:nth(I + 1, lists:nth(J + 1, DP)) of
                0 ->
                    Max = 0,
                    Directions = [{-1, 1}, {0, 1}, {1, 1}],
                    lists:foldl(fun({Di, Dj}, Acc) ->
                        NewI = I + Di,
                        NewJ = J + Dj,
                        if
                            NewI >= 0, NewI < M, NewJ >= 0, NewJ < N, GridNewI + 1NewJ + 1 > GridI + 1J + 1 ->
                                Moves = max_moves(Grid, DP, NewI, NewJ),
                                max(Acc, Moves + 1);
                            true -> Acc
                        end
                    end, 0, Directions),
                    NewDP = update_dp(DP, I, J, Max),
                    Max;
                Val -> Val
            end
    end.

update_dp(DP, I, J, Val) ->
    Row = lists:nth(I + 1, DP),
    NewRow = lists:sublist(Row, J) ++ [Val] ++ lists:nthtail(J + 1, Row),
    lists:sublist(DP, I) ++ [NewRow] ++ lists:nthtail(I + 1, DP).