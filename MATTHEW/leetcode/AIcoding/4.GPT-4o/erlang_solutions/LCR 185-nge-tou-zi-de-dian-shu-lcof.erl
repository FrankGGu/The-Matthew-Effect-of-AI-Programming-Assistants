-module(solution).
-export([probability/3]).

probability(N, K, P) ->
    probability(N, K, P, 0).

probability(_, 0, _, Acc) -> 
    Acc;
probability(N, K, P, Acc) ->
    if
        N < K -> 
            Acc; 
        true -> 
            NewAcc = Acc + comb(N, K) * (P ^ K) * ((1 - P) ^ (N - K)),
            probability(N - 1, K, P, NewAcc)
    end.

comb(N, K) when K =< N -> 
    fact(N) div (fact(K) * fact(N - K));
comb(_, _) -> 
    0.

fact(0) -> 1;
fact(N) -> N * fact(N - 1).