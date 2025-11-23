-module(max_prime_difference).
-export([max_prime_diff/1]).

is_prime(N) ->
    is_prime(N, 2).

is_prime(N, I) when I * I > N ->
    true;
is_prime(N, I) when N rem I == 0 ->
    false;
is_prime(N, I) ->
    is_prime(N, I + 1).

max_prime_diff(Nums) ->
    Primes = [X || X <- Nums, is_prime(X)],
    lists:max(Primes) - lists:min(Primes).