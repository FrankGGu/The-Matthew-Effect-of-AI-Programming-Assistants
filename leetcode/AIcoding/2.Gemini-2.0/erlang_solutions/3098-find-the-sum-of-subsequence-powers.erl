-module(solution).
-export([sum_of_powers/1]).

sum_of_powers(Nums) ->
  lists:foldl(
    fun(Num, Acc) ->
      (Acc + power(Num, 2)) rem 1000000007
    end,
    0,
    lists:sort(Nums)
  ).

power(X, Y) ->
  power_helper(X, Y, 1).

power_helper(_, 0, Acc) ->
  Acc rem 1000000007;
power_helper(X, Y, Acc) ->
  power_helper((X * X) rem 1000000007, Y div 2, (if Y rem 2 == 1 then (Acc * X) rem 1000000007 else Acc end)).