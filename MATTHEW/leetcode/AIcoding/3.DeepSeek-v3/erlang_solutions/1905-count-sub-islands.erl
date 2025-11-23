-spec count_sub_islands(Grid1 :: [[integer()]], Grid2 :: [[integer()]]) -> integer().
count_sub_islands(Grid1, Grid2) ->
    M = length(Grid1),
    N = length(hd(Grid1)),
    Visited = lists:duplicate(M, lists:duplicate(N, false)),
    {Count, _} = lists:foldl(fun(I, {Cnt, V}) ->
        lists:foldl(fun(J, {C, Vis}) ->
            case (lists:nth(J+1, lists:nth(I+1, Grid2)) =:= 1 andalso (not lists:nth(J+1, lists:nth(I+1, Vis))) of
                true ->
                    case is_sub_island(Grid1, Grid2, I, J, M, N, Vis) of
                        true -> {C + 1, mark_visited(Vis, I, J, M, N)};
                        false -> {C, mark_visited(Vis, I, J, M, N)}
                    end;
                false -> {C, Vis}
            end
        end, {Cnt, V}, lists:seq(0, N-1))
    end, {0, Visited}, lists:seq(0, M-1)),
    Count.

is_sub_island(Grid1, Grid2, I, J, M, N, Visited) ->
    case I < 0 orelse I >= M orelse J < 0 orelse J >= N orelse (lists:nth(J+1, lists:nth(I+1, Visited))) orelse (lists:nth(J+1, lists:nth(I+1, Grid2)) =:= 0) of
        true -> true;
        false ->
            case lists:nth(J+1, lists:nth(I+1, Grid1)) =:= 1 of
                false -> false;
                true ->
                    NewVisited = mark_visited(Visited, I, J, M, N),
                    is_sub_island(Grid1, Grid2, I+1, J, M, N, NewVisited) andalso
                    is_sub_island(Grid1, Grid2, I-1, J, M, N, NewVisited) andalso
                    is_sub_island(Grid1, Grid2, I, J+1, M, N, NewVisited) andalso
                    is_sub_island(Grid1, Grid2, I, J-1, M, N, NewVisited)
            end
    end.

mark_visited(Visited, I, J, M, N) ->
    Row = lists:nth(I+1, Visited),
    NewRow = setnth(J+1, Row, true),
    setnth(I+1, Visited, NewRow).

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N-1, T, X)].