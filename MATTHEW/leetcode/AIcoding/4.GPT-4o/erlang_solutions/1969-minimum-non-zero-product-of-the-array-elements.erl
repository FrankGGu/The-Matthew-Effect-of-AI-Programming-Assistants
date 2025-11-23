-module(solution).
-export([min_non_zero_product/1]).

min_non_zero_product(N) ->
    Max = (1 bsl N) - 1,
    Mod = 1000000007,
    Power = (Max - 1) * (1 bsl (N - 1)) rem (Mod - 1),
    (Max * pow_mod(Max - 1, Power, Mod)) rem Mod.

pow_mod(_, 0, Mod) -> 1;
pow_mod(Base, Exp, Mod) ->
    case Exp rem 2 of
        0 -> 
            (pow_mod(Base * Base rem Mod, Exp div 2, Mod)) rem Mod;
        _ -> 
            (Base * pow_mod(Base, Exp - 1, Mod)) rem Mod
    end.