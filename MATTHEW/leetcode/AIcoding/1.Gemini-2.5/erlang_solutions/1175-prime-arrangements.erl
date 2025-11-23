-module(solution).
-export([num_prime_arrangements/1]).

MOD = 1000000007.

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 == 0 -> false;
is_prime(N) -> is_prime_check(N, 3).

is_prime_check(N, D) when D * D > N -> true;
is_prime_check(N, D) when N rem D == 0 -> false;
is_prime_check(N, D) -> is_prime_check(N, D + 2).

count_primes(N) ->
    count_primes(N, 1, 0).

count_primes(N, Current, Acc) when Current > N -> Acc;
count_primes(N, Current, Acc) ->
    case is_prime(Current) of
        true -> count_primes(N, Current + 1, Acc + 1);
        false -> count_primes(N, Current + 1, Acc)
    end.

factorial(0) -> 1;
factorial(N) -> (N * factorial(N - 1)) rem MOD.

num_prime_arrangements(N) ->
    PrimeCount = count_primes(N),
    NonPrimeCount = N - PrimeCount,
    (factorial(PrimeCount) * factorial(NonPrimeCount)) rem MOD.