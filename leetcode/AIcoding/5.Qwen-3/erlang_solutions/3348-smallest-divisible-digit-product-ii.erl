-module(small_divisible_digit_product_ii).
-export([smallest_number/1]).

smallest_number(N) ->
    smallest_number(N, 1).

smallest_number(N, K) ->
    Product = product_of_digits(K),
    if
        Product == N -> K;
        true -> smallest_number(N, K + 1)
    end.

product_of_digits(0) -> 0;
product_of_digits(N) ->
    product_of_digits(N, 1).

product_of_digits(0, Acc) -> Acc;
product_of_digits(N, Acc) ->
    Digit = N rem 10,
    product_of_digits(N div 10, Acc * Digit).