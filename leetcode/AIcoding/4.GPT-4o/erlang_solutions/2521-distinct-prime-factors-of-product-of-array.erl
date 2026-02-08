-module(solution).
-export([distinct_prime_factors/1]).

distinct_prime_factors(Nums) ->
    Product = lists:foldl(fun(X, Acc) -> Acc * X end, 1, Nums),
    distinct_primes(Product, []).

distinct_primes(1, Primes) ->
    lists:usort(Primes);
distinct_primes(N, Primes) ->
    case smallest_prime_factor(N) of
        0 -> lists:usort(Primes);
        Factor ->
            distinct_primes(div(N, Factor), [Factor | Primes])
    end.

smallest_prime_factor(N) when N < 2 -> 0;
smallest_prime_factor(N) ->
    lists:foldl(fun(X, Acc) ->
        case Acc of 
            0 -> if N rem X =:= 0 -> X; true -> 0 end;
            _ -> Acc
        end
    end, 0, lists:seq(2, trunc(math:sqrt(N)))).