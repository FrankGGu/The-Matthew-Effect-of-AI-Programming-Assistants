-module(distinct_prime_factors).
-export([distinct_prime_factors/1]).

distinct_prime_factors(Nums) ->
    Product = lists:foldl(fun(X, Acc) -> X * Acc end, 1, Nums),
    PrimeFactors = prime_factors(Product, 2, sets:new()),
    sets:size(PrimeFactors).

prime_factors(1, _, Factors) -> Factors;
prime_factors(N, P, Factors) when N rem P =:= 0 ->
    NewFactors = sets:add_element(P, Factors),
    prime_factors(N div P, P, NewFactors);
prime_factors(N, P, Factors) ->
    prime_factors(N, P + 1, Factors).