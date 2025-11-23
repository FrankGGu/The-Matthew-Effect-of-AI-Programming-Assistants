-module(distinct_prime_factors).
-export([distinct_prime_factors/1]).

distinct_prime_factors(Nums) ->
    distinct_prime_factors_helper(Nums, sets:new()).

distinct_prime_factors_helper([], Acc) ->
    sets:size(Acc);
distinct_prime_factors_helper([H|T], Acc) ->
    Primes = prime_factors(H, []),
    NewAcc = lists:foldl(fun(P, A) -> sets:add_element(P, A) end, Acc, Primes),
    distinct_prime_factors_helper(T, NewAcc).

prime_factors(1, Acc) ->
    Acc;
prime_factors(N, Acc) ->
    prime_factors_helper(N, 2, Acc).

prime_factors_helper(1, _, Acc) ->
    Acc;
prime_factors_helper(N, I, Acc) when I * I > N ->
    [N|Acc];
prime_factors_helper(N, I, Acc) when N rem I == 0 ->
    prime_factors_helper(N div I, I, [I|Acc]);
prime_factors_helper(N, I, Acc) ->
    prime_factors_helper(N, I + 1, Acc).