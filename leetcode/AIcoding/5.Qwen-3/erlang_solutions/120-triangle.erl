-module(triangle).
-export([minimum_total/1]).

minimum_total(Triangle) ->
    lists:foldl(fun(Row, Acc) ->
        lists:zipwith(fun(A, B) -> A + min(hd(Acc), hd(tl(Acc))) end, Row, Acc)
    end, [0], Triangle).

minimum_total([]) ->
    0.