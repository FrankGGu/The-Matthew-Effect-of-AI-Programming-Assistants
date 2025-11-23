-module(solution).
-export([find_x_value/2]).

find_x_value(A, x) ->
    lists:foldl(fun(X, Acc) -> Acc + if X == x -> 1; true -> 0 end end, 0, A).