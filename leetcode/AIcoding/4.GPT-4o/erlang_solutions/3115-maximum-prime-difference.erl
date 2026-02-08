-module(solution).
-export([maximum_prime_difference/1]).

maximum_prime_difference(N) when N > 1 ->
    Primes = lists:filter(fun(X) -> is_prime(X) end, lists:seq(2, N)),
    case Primes of
        [] -> 0;
        _ -> lists:max(Primes) - lists:min(Primes)
    end.

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) -> not lists:any(fun(X) -> N rem X =:= 0 end, lists:seq(2, trunc(math:sqrt(N)))).