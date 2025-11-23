-module(solution).
-export([guard_space_city/1]).

guard_space_city(A) ->
    lists:foldl(fun(X, Acc) -> Acc + X end, 0, A).