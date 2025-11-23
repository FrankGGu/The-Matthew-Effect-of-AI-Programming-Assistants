-module(min_xor_operations).
-export([min_operations/2]).

min_operations(Nums, K) ->
  lists:foldl(
    fun(Num, Acc) ->
      Acc + (if (Num band K) /= Num then 1 else 0 end)
    end,
    0,
    Nums
  ).