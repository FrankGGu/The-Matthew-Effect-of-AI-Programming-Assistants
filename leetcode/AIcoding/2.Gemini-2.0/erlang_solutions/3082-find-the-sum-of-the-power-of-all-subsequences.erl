-module(solution).
-export([sum_power/1]).

sum_power(Nums) ->
  N = length(Nums),
  Mod = 1000000007,
  sum_power_helper(Nums, N, Mod).

sum_power_helper(Nums, N, Mod) ->
  lists:foldl(
    fun(Num, Acc) ->
      (Acc + (power(2, N - 1, Mod) * Num * Num) rem Mod +
       (power(2, N, Mod - 1) * Num * lists:sum(Nums) rem Mod) rem Mod) rem Mod
    end,
    0,
    Nums
  ).

power(Base, Exp, Mod) ->
  power_helper(Base, Exp, Mod, 1).

power_helper(_, 0, _, Acc) ->
  Acc;
power_helper(Base, Exp, Mod, Acc) ->
  if Exp rem 2 == 0 ->
    power_helper((Base * Base) rem Mod, Exp div 2, Mod, Acc);
  true ->
    power_helper(Base, Exp - 1, Mod, (Acc * Base) rem Mod)
  end.