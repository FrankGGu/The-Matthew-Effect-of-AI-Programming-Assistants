-module(solution).
-export([modify_columns/2]).

modify_columns(M, X) ->
    Rows = lists:map(fun(Row) -> lists:map(fun({C, I}) -> if I rem X == 0 -> C + 1; true -> C end end, lists:zip(Row, lists:seq(1, length(Row)))) end, M),
    lists:map(fun(Row) -> lists:map(fun(C) -> if C rem 2 == 0 -> C + 1; true -> C end end, Row) end, Rows).