-module(count_collisions).
-export([solve/1]).

solve(n) ->
  Mod = 1000000007,
  power(2, n, Mod) - 2 rem Mod.

power(Base, Exp, Mod) ->
  power_helper(Base rem Mod, Exp, 1, Mod).

power_helper(_, 0, Acc, _) ->
  Acc;
power_helper(Base, Exp, Acc, Mod) ->
  if Exp rem 2 == 0 ->
    power_helper(Base * Base rem Mod, Exp div 2, Acc, Mod);
  true ->
    power_helper(Base, Exp - 1, Acc * Base rem Mod, Mod)
  end.