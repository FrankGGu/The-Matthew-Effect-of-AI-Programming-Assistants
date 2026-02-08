-module(solution).
-export([trailingZeroes/1]).

trailingZeroes(N) ->
    trailingZeroes_iter(N, 0).

trailingZeroes_iter(0, Acc) ->
    Acc;
trailingZeroes_iter(N, Acc) ->
    NewN = N div 5,
    NewAcc = Acc + NewN,
    trailingZeroes_iter(NewN, NewAcc).