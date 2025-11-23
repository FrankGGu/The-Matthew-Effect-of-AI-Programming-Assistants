-module(solution).
-export([play/1]).

play(Toys) ->
    lists:foldl(fun(T, Acc) -> Acc + T end, 0, Toys).