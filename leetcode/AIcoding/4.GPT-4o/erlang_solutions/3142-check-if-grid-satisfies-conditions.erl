-module(solution).
-export([check_grid/1]).

check_grid(Grid) ->
    Rows = length(Grid),
    Columns = length(hd(Grid)),
    lists:all(fun(Row) -> lists:all(fun(X) -> X >= 1, X =< 9 end, Row) end, Grid) andalso
    lists:all(fun(C) -> lists:all(fun(X) -> X >= 1, X =< 9 end, C) end, transpose(Grid)) andalso
    lists:all(fun({X, Y}) -> (lists:nth(Y, Grid) - lists:nth(X, Grid)) rem 2 == 0 end, [{X, Y} || X <- lists:seq(1, Rows), Y <- lists:seq(1, Columns)]).

transpose([]) -> [];
transpose([H|T]) -> [lists:map(fun(X) -> hd(X) end, [H|T]) | transpose(lists:map(fun(X) -> tl(X) end, [H|T]))].