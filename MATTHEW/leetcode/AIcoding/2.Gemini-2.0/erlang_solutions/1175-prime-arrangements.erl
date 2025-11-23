-module(prime_arrangements).
-export([num_prime_arrangements/1]).

num_prime_arrangements(N) ->
    Primes = primes_count(N),
    NonPrimes = N - Primes,
    (factorial(Primes) * factorial(NonPrimes)) rem 1000000007.

primes_count(N) ->
    primes_count(N, 2, 0).

primes_count(N, K, Count) when K > N ->
    Count;
primes_count(N, K, Count) ->
    case is_prime(K) of
        true ->
            primes_count(N, K+1, Count+1);
        false ->
            primes_count(N, K+1, Count)
    end.

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) ->
    is_prime(N, 2).

is_prime(N, K) when K*K > N -> true;
is_prime(N, K) when N rem K == 0 -> false;
is_prime(N, K) -> is_prime(N, K+1).

factorial(0) -> 1;
factorial(1) -> 1;
factorial(N) ->
    factorial(N, 1, 1).

factorial(N, K, Acc) when K > N -> Acc rem 1000000007;
factorial(N, K, Acc) ->
    factorial(N, K+1, (Acc * K) rem 1000000007).