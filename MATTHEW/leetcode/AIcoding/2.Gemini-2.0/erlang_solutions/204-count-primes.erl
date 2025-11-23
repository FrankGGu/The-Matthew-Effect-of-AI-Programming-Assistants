-module(count_primes).
-export([countPrimes/1]).

countPrimes(N) ->
    if N < 3 then
        0
    else
        Sieve = lists:seq(2, N - 1),
        countPrimesHelper(Sieve, [], N)
    end.

countPrimesHelper([], Acc, _) ->
    length(Acc);
countPrimesHelper([H|T], Acc, N) ->
    NewT = lists:filter(fun(X) -> X rem H /= 0 end, T),
    countPrimesHelper(NewT, [H|Acc], N).