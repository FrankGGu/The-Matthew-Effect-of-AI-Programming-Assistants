-module(element_digit_sum).
-export([subtract_product_and_sum/1]).

subtract_product_and_sum(Nums) ->
    element_sum(Nums) - digit_sum(Nums).

element_sum(Nums) ->
    lists:sum(Nums).

digit_sum(Nums) ->
    lists:sum([sum_digits(Num) || Num <- Nums]).

sum_digits(0) ->
    0;
sum_digits(N) when N > 0 ->
    (N rem 10) + sum_digits(N div 10).