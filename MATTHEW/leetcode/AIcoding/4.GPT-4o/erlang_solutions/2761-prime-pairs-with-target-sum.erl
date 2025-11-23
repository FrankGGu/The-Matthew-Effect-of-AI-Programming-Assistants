-module(solution).
-export([prime_pairs/2]).

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) -> 
    lists:all(fun(X) -> N rem X /= 0 end, lists:seq(2, trunc(math:sqrt(N)))).

generate_primes(Limit) -> 
    lists:filter(fun is_prime/1, lists:seq(2, Limit)).

prime_pairs(Target, Limit) ->
    Primes = generate_primes(Limit),
    Pairs = [{X, Y} || X <- Primes, Y <- Primes, X < Y, X + Y =:= Target],
    lists:map(fun({X, Y}) -> [X, Y] end, Pairs).