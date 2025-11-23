-module(solution).
-export([make_array_empty/1]).

make_array_empty(Array) ->
    lists:foldl(fun(X, Acc) -> Acc + (X rem 2) end, 0, Array).