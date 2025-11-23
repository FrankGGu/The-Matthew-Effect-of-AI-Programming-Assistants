-module(solution).
-export([num_prime_arrangements/1]).

num_prime_arrangements(N) ->
    Primes = count_primes(N),
    FactPrimes = factorial(Primes),
    FactNonPrimes = factorial(N - Primes),
    (FactPrimes * FactNonPrimes) rem 1000000007.

count_primes(N) ->
    if N < 2 -> 0;
       true ->
            Sieve = lists:duplicate(N + 1, true),
            Sieve1 = setelement(1, Sieve, false),
            Sieve2 = setelement(2, Sieve1, false),
            count_primes_helper(2, N, Sieve2, 0)
    end.

count_primes_helper(I, N, Sieve, Count) when I * I > N ->
    Count + lists:sum([1 || X <- lists:seq(2, N), element(X, Sieve)]);
count_primes_helper(I, N, Sieve, Count) ->
    case element(I, Sieve) of
        true ->
            SieveNew = mark_non_primes(I, I, N, Sieve),
            count_primes_helper(I + 1, N, SieveNew, Count + 1);
        false ->
            count_primes_helper(I + 1, N, Sieve, Count)
    end.

mark_non_primes(Prime, Multiple, N, Sieve) when Multiple > N ->
    Sieve;
mark_non_primes(Prime, Multiple, N, Sieve) ->
    SieveNew = setelement(Multiple, Sieve, false),
    mark_non_primes(Prime, Multiple + Prime, N, SieveNew).

factorial(0) -> 1;
factorial(N) -> (N * factorial(N - 1)) rem 1000000007.