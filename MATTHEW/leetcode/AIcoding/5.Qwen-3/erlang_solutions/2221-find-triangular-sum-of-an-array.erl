-module(triangle_sum).
-export([numSimilarTriangles/1]).

numSimilarTriangles(Rows) ->
    Sum = lists:foldl(fun(Row, Acc) -> 
        lists:zipwith(fun(A, B) -> A + B end, Row, lists:tl(Row)) 
    end, Rows, lists:seq(1, length(Rows) - 1)),
    lists:last(Sum).