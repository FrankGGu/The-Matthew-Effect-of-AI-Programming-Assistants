-module(solution).
-export([max_beautiful_arrangement/1]).

max_beautiful_arrangement(N) ->
    lists:foldl(fun(_, Acc) -> Acc * 2 end, 1, lists:seq(1, N)).