-module(maximize_primes).
-export([max_distinct_primes/1]).

max_distinct_primes(Nums) ->
    max_distinct_primes(Nums, []).

max_distinct_primes([], Acc) ->
    length(Acc);
max_distinct_primes([Num|Rest], Acc) ->
    PrimeFactors = prime_factors(Num),
    max(max_distinct_primes(Rest, lists:usort(Acc ++ PrimeFactors)),
        max_distinct_primes(Rest, lists:usort(Acc)) + length(PrimeFactors)).

prime_factors(N) ->
    prime_factors(N, 2, []).

prime_factors(1, _, Acc) ->
    Acc;
prime_factors(N, I, Acc) when I * I > N ->
    [N | Acc];
prime_factors(N, I, Acc) when N rem I == 0 ->
    prime_factors(N div I, I, [I | Acc]);
prime_factors(N, I, Acc) ->
    prime_factors(N, I + 1, Acc).