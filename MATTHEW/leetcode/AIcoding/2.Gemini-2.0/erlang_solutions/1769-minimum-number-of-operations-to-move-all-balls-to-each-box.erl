-module(minimum_operations).
-export([min_operations/1]).

min_operations(Boxes) ->
    Len = length(Boxes),
    lists:map(fun(I) ->
        sum([abs(I - J) * (case lists:nth(J + 1, Boxes) of $1 -> 1; _ -> 0 end) || J <- lists:seq(0, Len - 1)])
    end, lists:seq(0, Len - 1)).