-module(solution).
-export([length_of_path/1]).

length_of_path(Road) ->
    lists:foldl(fun(X, Acc) -> Acc + X end, 0, Road).