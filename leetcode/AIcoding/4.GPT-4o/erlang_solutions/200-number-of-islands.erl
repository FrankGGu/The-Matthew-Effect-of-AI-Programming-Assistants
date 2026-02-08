%% -spec num_islands(Grid :: [[char()]]) -> integer().
num_islands(Grid) ->
    lists:foldl(fun(Row, Acc) -> explore_island(Row, Acc) end, 0, Grid).

explore_island([], Acc) -> Acc;
explore_island([H | T], Acc) when H == $1 -> explore_island(T, Acc + 1);
explore_island([_ | T], Acc) -> explore_island(T, Acc).
