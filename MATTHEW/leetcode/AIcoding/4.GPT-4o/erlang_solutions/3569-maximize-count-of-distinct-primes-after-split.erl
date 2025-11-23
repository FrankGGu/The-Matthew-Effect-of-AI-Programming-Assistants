-module(solution).
-export([max_distinct_primes/1]).

max_distinct_primes(N) ->
    primes = sieve(N),
    distinct_primes_count(primes, N).

sieve(N) ->
    lists:seq(2, N)
    |> lists:map(fun(X) -> {X, is_prime(X)} end)
    |> lists:filter(fun({_, true}) -> true; (_) -> false end)
    |> lists:map(fun({P, _}) -> P end).

is_prime(2) -> true;
is_prime(N) when N < 2 -> false;
is_prime(N) ->
    lists:all(fun(X) -> N rem X /= 0 end, lists:seq(2, trunc(math:sqrt(N)))).

distinct_primes_count(Primes, N) ->
    case N of
        0 -> 0;
        _ -> length(Primes)
    end.