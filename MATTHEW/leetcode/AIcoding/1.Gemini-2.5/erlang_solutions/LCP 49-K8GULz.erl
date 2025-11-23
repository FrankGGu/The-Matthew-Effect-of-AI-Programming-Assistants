-module(solution).
-export([solve/2]).

solve(N, K) ->
    josephus_formula(N, K, 0, 1).

josephus_formula(N, K, Acc, I) when I < N ->
    NewAcc = (Acc + K) rem (I + 1),
    josephus_formula(N, K, NewAcc, I + 1);
josephus_formula(_N, _K, Acc, _I) ->
    Acc.