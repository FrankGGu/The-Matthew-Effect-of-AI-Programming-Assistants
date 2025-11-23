-module(solution).
-export([apply_operations/1]).

apply_operations(Array) ->
    Max = lists:max(Array),
    lists:map(fun(X) -> if X == Max -> 0; true -> X end end, Array).