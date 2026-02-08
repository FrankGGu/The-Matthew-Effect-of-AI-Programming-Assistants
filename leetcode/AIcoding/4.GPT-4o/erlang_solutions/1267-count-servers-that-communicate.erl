-module(solution).
-export([count_servers/1]).

count_servers(Grid) ->
    {Rows, Cols} = lists:foldl(fun(Row, {R, C}) -> {R + 1, max(C, length(Row))} end, {0, 0}, Grid),
    ServerCounts = lists:map(fun(Row) -> lists:map(fun(X) -> if X == 1 -> 1; true -> 0 end end, Row) end, Grid),
    RowSums = lists:map(fun(Row) -> lists:sum(Row) end, ServerCounts),
    ColSums = lists:map(fun(Col) -> lists:sum(lists:map(fun(Row) -> lists:nth(Col + 1, Row) end, Grid)) end, lists:seq(0, Cols - 1)),
    lists:sum(lists:map(fun({Row, RIndex}) -> lists:sum(lists:map(fun({Col, CIndex}) -> if lists:nth(RIndex + 1, ServerCounts) > 1 orelse lists:nth(CIndex + 1, ColSums) > 1 -> 1; true -> 0 end end, lists:zip(Row, lists:seq(0, Cols - 1))) end, lists:zip(Grid, lists:seq(0, Rows - 1))) end).