-module(prime_arrangements).
-export([numPrimeArrangements/1]).

numPrimeArrangements(N) ->
    Primes = count_primes(N),
    factorial(Primes) * factorial(N - Primes).

count_primes(0) -> 0;
count_primes(1) -> 0;
count_primes(N) ->
    count_primes(N, 2, 0).

count_primes(N, I, Count) when I > N ->
    Count;
count_primes(N, I, Count) ->
    case is_prime(I) of
        true -> count_primes(N, I + 1, Count + 1);
        false -> count_primes(N, I + 1, Count)
    end.

is_prime(2) -> true;
is_prime(I) when I < 2 -> false;
is_prime(I) ->
    is_prime(I, 2).

is_prime(I, Div) when Div * Div > I -> true;
is_prime(I, Div) ->
    case I rem Div of
        0 -> false;
        _ -> is_prime(I, Div + 1)
    end.

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).