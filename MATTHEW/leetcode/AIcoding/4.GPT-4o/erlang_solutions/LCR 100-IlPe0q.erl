-module(solution).
-export([minimum_total/1]).

minimum_total(Triangle) ->
    lists:foldr(fun(Row, Acc) ->
        lists:zipwith(fun(X, Y) -> X + min(Y) end, Row, Acc)
    end, lists:last(Triangle), lists:reverse(Triangle)).