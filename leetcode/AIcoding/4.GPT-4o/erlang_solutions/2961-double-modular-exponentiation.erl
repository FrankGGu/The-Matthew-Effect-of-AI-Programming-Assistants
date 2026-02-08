-module(solution).
-export([mod_exp/3, double_mod_exp/4]).

mod_exp(_, 0, _) -> 1;
mod_exp(Base, Exp, Mod) ->
    Temp = mod_exp(Base, Exp div 2, Mod),
    Result = (Temp * Temp) rem Mod,
    if
        Exp rem 2 == 1 -> (Result * Base) rem Mod;
        true -> Result
    end.

double_mod_exp(A, B, C, D) ->
    X = mod_exp(A, B, C),
    Y = mod_exp(A, D, C),
    {X, Y}.