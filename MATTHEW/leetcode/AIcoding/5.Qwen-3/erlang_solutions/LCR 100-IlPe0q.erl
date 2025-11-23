-module(triangle_min_path_sum).
-export([minimum_total/1]).

minimum_total(Triangle) ->
    lists:foldl(fun(Row, Acc) -> 
        lists:zipwith(fun(A, B) -> min(A + B, B + hd(lists:reverse(Acc))) end, Row, Acc)
    end, [0], Triangle).

minimum_total([]) ->
    0.