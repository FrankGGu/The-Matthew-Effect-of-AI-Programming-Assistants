-module(maximum_product_of_two_digits).
-export([max_product/1]).

max_product(N) ->
  Digits = integer_to_list(N),
  max_product_helper(Digits, 0).

max_product_helper([H|T], Max) ->
  max_product_helper(T, max(Max, list_to_integer([H]) * list_to_integer(T)));
max_product_helper([], Max) ->
  Max.