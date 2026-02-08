-module(solution).
-export([check_valid/1]).

check_valid(Board) ->
    Size = length(Board),
    check_rows(Board, Size) andalso check_columns(Board, Size).

check_rows([], _Size) -> true;
check_rows([Row | Rest], Size) ->
    lists:sort(Row) =:= lists:seq(1, Size) andalso check_rows(Rest, Size).

check_columns(Board, Size) ->
    Columns = lists:map(fun(Index) -> lists:map(fun(Row) -> lists:nth(Index + 1, Row) end, Board) end, lists:seq(0, Size - 1)),
    lists:all(fun(Column) -> lists:sort(Column) =:= lists:seq(1, Size) end, Columns).