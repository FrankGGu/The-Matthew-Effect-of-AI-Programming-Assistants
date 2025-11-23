-spec unique_paths_iii(Grid :: [[integer()]]) -> integer().
unique_paths_iii(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {StartR, StartC, Total} = find_start_and_total(Grid, Rows, Cols, 0, 0, 0),
    dfs(Grid, Rows, Cols, StartR, StartC, Total, 0).

find_start_and_total([], _, _, R, C, Total) -> {R, C, Total};
find_start_and_total([Row | Rest], Rows, Cols, R, C, Total) ->
    find_start_and_total_row(Row, Rest, Rows, Cols, R, 0, Total).

find_start_and_total_row([], Rest, Rows, Cols, R, C, Total) ->
    find_start_and_total(Rest, Rows, Cols, R + 1, C, Total);
find_start_and_total_row([1 | T], Rest, Rows, Cols, R, C, Total) ->
    find_start_and_total_row(T, Rest, Rows, Cols, R, C + 1, Total + 1, R, C);
find_start_and_total_row([2 | T], Rest, Rows, Cols, R, C, Total) ->
    find_start_and_total_row(T, Rest, Rows, Cols, R, C + 1, Total + 1);
find_start_and_total_row([0 | T], Rest, Rows, Cols, R, C, Total) ->
    find_start_and_total_row(T, Rest, Rows, Cols, R, C + 1, Total + 1);
find_start_and_total_row([_ | T], Rest, Rows, Cols, R, C, Total) ->
    find_start_and_total_row(T, Rest, Rows, Cols, R, C + 1, Total).

dfs(Grid, Rows, Cols, R, C, Total, Visited) ->
    if
        R < 0 orelse C < 0 orelse R >= Rows orelse C >= Cols -> 0;
        true ->
            Cell = lists:nth(C + 1, lists:nth(R + 1, Grid)),
            if
                Cell =:= -1 -> 0;
                Cell =:= 2 -> if Visited =:= Total -> 1; true -> 0 end;
                true ->
                    NewGrid = mark_visited(Grid, R, C),
                    Dir = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    lists:sum([dfs(NewGrid, Rows, Cols, R + DR, C + DC, Total, Visited + 1) || {DR, DC} <- Dir])
            end
    end.

mark_visited(Grid, R, C) ->
    Row = lists:nth(R + 1, Grid),
    NewRow = lists:sublist(Row, C) ++ [-1] ++ lists:nthtail(C + 1, Row),
    lists:sublist(Grid, R) ++ [NewRow] ++ lists:nthtail(R + 1, Grid).