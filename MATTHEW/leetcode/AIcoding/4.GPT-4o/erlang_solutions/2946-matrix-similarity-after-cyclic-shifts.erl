-module(solution).
-export([are_similar/2]).

are_similar(Matrix1, Matrix2) ->
    N = length(Matrix1),
    Rows1 = lists:flatten(Matrix1),
    Rows2 = lists:flatten(Matrix2),
    lists:any(fun(Shifted) -> Rows1 =:= Shifted end, lists:map(fun(Row) -> rotate(Row, N) end, Rows2)).

rotate(Row, N) ->
    lists:map(fun(I) -> lists:nth(((I + 1) rem N) + 1, Row) end, lists:seq(0, N - 1)).