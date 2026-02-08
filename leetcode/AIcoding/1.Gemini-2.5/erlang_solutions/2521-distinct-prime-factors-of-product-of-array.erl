-module(solution).
-export([distinct_prime_factors/1]).

distinct_prime_factors(Nums) ->
    sets:size(lists:foldl(fun(N, AccSet) ->
                                  prime_factors_of_number(N, AccSet)
                          end, sets:new(), Nums)).

prime_factors_of_number(N, AccSet) ->
    prime_factors_of_number_recursive(N, 2, AccSet).

prime_factors_of_number_recursive(1, _Divisor, AccSet) ->
    AccSet;
prime_factors_of_number_recursive(N, Divisor, AccSet) when Divisor * Divisor > N ->
    sets:add_element(N, AccSet);
prime_factors_of_number_recursive(N, Divisor, AccSet) when N rem Divisor == 0 ->
    NewAccSet = sets:add_element(Divisor, AccSet),
    prime_factors_of_number_divide(N, Divisor, NewAccSet);
prime_factors_of_number_recursive(N, Divisor, AccSet) ->
    prime_factors_of_number_recursive(N, Divisor + 1, AccSet).

prime_factors_of_number_divide(N, Divisor, AccSet) when N rem Divisor == 0 ->
    prime_factors_of_number_divide(N div Divisor, Divisor, AccSet);
prime_factors_of_number_divide(N, Divisor, AccSet) ->
    prime_factors_of_number_recursive(N, Divisor + 1, AccSet).