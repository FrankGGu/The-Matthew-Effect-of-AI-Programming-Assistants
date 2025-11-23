-module(solution).
-export([prime_subtraction/2]).

prime_subtraction(N, K) ->
    Max = N - K,
    Primes = generate_primes(Max),
    is_prime_subtraction_possible(N, Primes).

generate_primes(Max) ->
    lists:filter(fun(X) -> is_prime(X) end, lists:seq(2, Max)).

is_prime(2) -> true;
is_prime(N) when N > 2 ->
    not lists:any(fun(X) -> N rem X == 0 end, lists:seq(2, trunc(math:sqrt(N)))).

is_prime_subtraction_possible(N, Primes) ->
    lists:any(fun(P) -> N - P >= 0 end, Primes).