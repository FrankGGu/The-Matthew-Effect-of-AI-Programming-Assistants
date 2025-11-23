-module(solution).
-export([encrypt_operation/2]).

encrypt_operation(A, B) ->
    Mod = 1000000007,
    mod_pow(A, B, Mod).

mod_pow(_, 0, _Mod) -> 1;
mod_pow(Base, Exp, Mod) ->
    Result = mod_pow(Base, Exp div 2, Mod),
    Squared = (Result * Result) rem Mod,
    if
        Exp rem 2 == 1 -> (Squared * (Base rem Mod)) rem Mod;
        true -> Squared
    end.