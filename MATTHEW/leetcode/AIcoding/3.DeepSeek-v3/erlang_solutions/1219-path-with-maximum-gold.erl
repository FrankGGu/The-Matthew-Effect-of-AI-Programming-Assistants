-spec get_maximum_gold(Grid :: [[integer()]]) -> integer().
get_maximum_gold(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Max = lists:foldl(fun(I, Acc1) ->
        lists:foldl(fun(J, Acc2) ->
            case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
                0 -> Acc2;
                _ -> max(Acc2, dfs(Grid, I, J, M, N))
            end
        end, Acc1, lists:seq(0, N - 1))
    end, 0, lists:seq(0, M - 1)),
    Max.

dfs(Grid, I, J, M, N) ->
    if
        I < 0; I >= M; J < 0; J >= N -> 0;
        true ->
            Row = lists:nth(I + 1, Grid),
            Val = lists:nth(J + 1, Row),
            if
                Val == 0 -> 0;
                true ->
                    NewRow = setelement(J + 1, Row, 0),
                    NewGrid = setelement(I + 1, Grid, NewRow),
                    Dir = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    lists:foldl(fun({Di, Dj}, Acc) ->
                        max(Acc, Val + dfs(NewGrid, I + Di, J + Dj, M, N))
                    end, 0, Dir)
            end
    end.