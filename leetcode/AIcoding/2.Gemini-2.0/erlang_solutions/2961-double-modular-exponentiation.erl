-module(double_modular_exponentiation).
-export([double_modular_exponentiation/1]).

double_modular_exponentiation(Queries) ->
  lists:map(fun(Query) -> solve(Query) end, Queries).

solve([A, B, C, D]) ->
  MA = 1000000007,
  MB = 1000000009,
  R1 = mod_exp(A, B, MA),
  R2 = mod_exp(C, D, MB),
  [R1, R2].

mod_exp(Base, Exp, Mod) ->
  mod_exp_helper(Base, Exp, Mod, 1).

mod_exp_helper(_, 0, _, Acc) ->
  Acc;
mod_exp_helper(Base, Exp, Mod, Acc) ->
  if Exp rem 2 == 1 ->
    mod_exp_helper((Base * Base) rem Mod, Exp div 2, Mod, (Acc * Base) rem Mod);
  true ->
    mod_exp_helper((Base * Base) rem Mod, Exp div 2, Mod, Acc)
  end.