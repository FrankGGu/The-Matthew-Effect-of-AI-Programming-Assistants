-module(solution).
-export([superPow/2]).

superPow(A, B) ->
    Mod = 1337,
    A_reduced = A rem Mod,
    lists:foldl(fun(Digit, Acc) ->
        (pow_mod(Acc, 10, Mod) * pow_mod(A_reduced, Digit, Mod)) rem Mod
    end, 1, B).

pow_mod(Base, 0, _Mod) -> 1;
pow_mod(Base, Exp, Mod) when Exp rem 2 == 0 ->
    pow_mod((Base * Base) rem Mod, Exp div 2, Mod);
pow_mod(Base, Exp, Mod) ->
    (Base * pow_mod((Base * Base) rem Mod, Exp div 2, Mod)) rem Mod.