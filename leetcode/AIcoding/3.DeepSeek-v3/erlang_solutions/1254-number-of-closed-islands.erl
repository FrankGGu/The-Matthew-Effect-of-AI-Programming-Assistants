-spec closed_island(Grid :: [[integer()]]) -> integer().
closed_island(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Visited = lists:duplicate(M, lists:duplicate(N, false)),
    Count = lists:foldl(
        fun(I, AccI) ->
            lists:foldl(
                fun(J, AccJ) ->
                    case (lists:nth(I + 1, Grid) == 0) andalso (not lists:nth(J + 1, lists:nth(I + 1, Visited))) of
                        true ->
                            case dfs(I, J, Grid, Visited, M, N) of
                                true -> AccJ + 1;
                                false -> AccJ
                            end;
                        false -> AccJ
                    end
                end,
                AccI,
                lists:seq(0, N - 1)
            )
        end,
        0,
        lists:seq(0, M - 1)
    ),
    Count.

dfs(I, J, Grid, Visited, M, N) ->
    case (I < 0) orelse (I >= M) orelse (J < 0) orelse (J >= N) of
        true -> false;
        false ->
            case (lists:nth(I + 1, Grid) == 1) orelse (lists:nth(J + 1, lists:nth(I + 1, Visited))) of
                true -> true;
                false ->
                    NewVisited = update_visited(I, J, Visited),
                    D1 = dfs(I + 1, J, Grid, NewVisited, M, N),
                    D2 = dfs(I - 1, J, Grid, NewVisited, M, N),
                    D3 = dfs(I, J + 1, Grid, NewVisited, M, N),
                    D4 = dfs(I, J - 1, Grid, NewVisited, M, N),
                    D1 andalso D2 andalso D3 andalso D4
            end
    end.

update_visited(I, J, Visited) ->
    Row = lists:nth(I + 1, Visited),
    NewRow = setelement(J + 1, list_to_tuple(Row), true),
    setelement(I + 1, list_to_tuple(Visited), NewRow).