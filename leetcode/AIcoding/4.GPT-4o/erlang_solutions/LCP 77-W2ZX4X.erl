-module(solution).
-export([runeReserve/2]).

runeReserve(RuneList, N) ->
    lists:foldl(fun(Rune, Acc) -> Acc + Rune end, 0, RuneList) rem N.