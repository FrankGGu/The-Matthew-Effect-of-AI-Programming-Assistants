-module(solution).
-export([distinct_prime_factors/1]).

distinct_prime_factors(Nums) ->
    Product = lists:foldl(fun(X, Acc) -> Acc * X end, 1, Nums),
    factors(Product, 2, sets:new()).

factors(1, _, Set) ->
    sets:size(Set);
factors(N, D, Set) when N rem D == 0 ->
    factors(N div D, D, sets:add_element(D, Set));
factors(N, D, Set) ->
    factors(N, D + 1, Set).