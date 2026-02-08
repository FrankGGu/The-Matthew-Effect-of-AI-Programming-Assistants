-module(solution).
-export([smallest_divisible_digit_product/1]).

smallest_divisible_digit_product(N) ->
    lists:min([X || X <- lists:seq(1, 1000000), is_divisible(X, N)]).

is_divisible(X, N) ->
    Digits = integer_to_list(X),
    lists:all(fun(D) -> D /= $0 end, Digits) andalso
    (product(Digits) rem N == 0).

product(Digits) ->
    lists:foldl(fun(D, Acc) -> (D - $0) * Acc end, 1, Digits).