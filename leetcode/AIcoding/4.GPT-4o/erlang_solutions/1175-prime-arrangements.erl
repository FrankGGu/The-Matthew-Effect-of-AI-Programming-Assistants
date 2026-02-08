-module(solution).
-export([numPrimeArrangements/1]).

numPrimeArrangements(N) when N >= 1, N =< 100 do
    PrimeCount = count_primes(N),
    Factorial = lists:foldl(fun(X, Acc) -> Acc * X rem 1000000007 end, 1, lists:seq(1, PrimeCount)) *
                 lists:foldl(fun(X, Acc) -> Acc * X rem 1000000007 end, 1, lists:seq(1, N - PrimeCount)) rem 1000000007,
    Factorial rem 1000000007.

count_primes(N) ->
    lists:sum([is_prime(X) || X <- lists:seq(2, N)]).

is_prime(2) -> 1;
is_prime(N) when N > 2, N rem 2 =:= 0 -> 0;
is_prime(N) -> 
    case lists:all(fun(X) -> N rem X /= 0 end, lists:seq(2, trunc(math:sqrt(N)))) of
        true -> 1;
        false -> 0
    end.