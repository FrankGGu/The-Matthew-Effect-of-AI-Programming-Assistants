-module(solution).
-export([mod_pow/3]).

mod_pow(_, 0, _) -> 1;
mod_pow(Base, Exponent, Mod) ->
    case Exponent rem 2 of
        0 -> 
            Result = mod_pow(Base, Exponent div 2, Mod),
            (Result * Result) rem Mod;
        1 -> 
            (Base * mod_pow(Base, Exponent - 1, Mod)) rem Mod
    end.