-module(solution).
-export([minimum_moves/1]).

minimum_moves(Classroom) ->
    Rows = length(Classroom),
    Columns = length(hd(Classroom)),
    Total = lists:foldl(fun(Row, Acc) -> Acc + lists:sum(Row) end, 0, Classroom),
    ceil(Total / 2).