-module(solution).
-export([countGoodNumbers/1]).

countGoodNumbers(N) ->
  Mod = 1000000007,
  A = power(5, (N + 1) div 2, Mod),
  B = power(4, N div 2, Mod),
  (A * B) rem Mod.

power(Base, Exp, Mod) ->
  power(Base, Exp, Mod, 1).

power(_, 0, _, Acc) ->
  Acc;
power(Base, Exp, Mod, Acc) ->
  if
    (Exp rem 2) == 0 ->
      power((Base * Base) rem Mod, Exp div 2, Mod, Acc);
    true ->
      power(Base, Exp - 1, Mod, (Acc * Base) rem Mod)
  end.