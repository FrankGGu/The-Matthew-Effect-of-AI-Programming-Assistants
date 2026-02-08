-module(solution).
-export([distinct_prime_factors/1]).

distinct_prime_factors(Nums) ->
    PrimeSets = lists:map(fun num_to_primes/1, Nums),
    Union = lists:foldl(fun(Set, Acc) -> sets:union(Set, Acc) end, sets:new(), PrimeSets),
    sets:size(Union).

num_to_primes(N) ->
    num_to_primes(N, 2, sets:new()).

num_to_primes(1, _, Acc) -> Acc;
num_to_primes(N, P, Acc) when P * P > N ->
    sets:add_element(N, Acc);
num_to_primes(N, P, Acc) when N rem P =:= 0 ->
    num_to_primes(N div P, P, sets:add_element(P, Acc));
num_to_primes(N, P, Acc) ->
    num_to_primes(N, P + 1, Acc).