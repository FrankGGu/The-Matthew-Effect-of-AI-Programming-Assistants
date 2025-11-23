-module(small_div).
-export([smallest_divisible/1]).

smallest_divisible(N) ->
    smallest_divisible(N, 1).

smallest_divisible(N, K) ->
    Product = product_of_digits(K),
    if
        Product rem N == 0 -> K;
        true -> smallest_divisible(N, K + 1)
    end.

product_of_digits(0) -> 1;
product_of_digits(K) ->
    Digit = K rem 10,
    Product = product_of_digits(K div 10),
    Product * Digit.