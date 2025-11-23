-module(infection_sequences).
-export([count_infection_sequences/1]).

count_infection_sequences(N) ->
  case N of
    0 -> 1;
    _ ->
      Mod = 1000000007,
      fact(N, Mod) * power(2, N, Mod) rem Mod
  end.

fact(N, Mod) ->
  fact_aux(N, 1, Mod).

fact_aux(0, Acc, _) ->
  Acc;
fact_aux(N, Acc, Mod) ->
  fact_aux(N - 1, (Acc * N) rem Mod, Mod).

power(Base, Exp, Mod) ->
  power_aux(Base, Exp, 1, Mod).

power_aux(_, 0, Acc, _) ->
  Acc;
power_aux(Base, Exp, Acc, Mod) ->
  if Exp rem 2 == 0 ->
    power_aux((Base * Base) rem Mod, Exp div 2, Acc, Mod);
  true ->
    power_aux(Base, Exp - 1, (Acc * Base) rem Mod, Mod)
  end.