-module(solution).
-export([subtract_product_and_sum/1]).

subtract_product_and_sum(N) ->
  Digits = integer_to_list(N),
  {Product, Sum} = lists:foldl(
    fun(Digit, {ProdAcc, SumAcc}) ->
      D = list_to_integer([Digit]),
      {ProdAcc * D, SumAcc + D}
    end,
    {1, 0},
    Digits
  ),
  Product - Sum.