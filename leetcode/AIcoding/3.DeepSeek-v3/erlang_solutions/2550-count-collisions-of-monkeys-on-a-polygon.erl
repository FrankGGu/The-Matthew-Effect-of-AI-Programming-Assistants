-module(solution).
-export([monkeyMove/1]).

-spec monkeyMove(N :: integer()) -> integer().
monkeyMove(N) ->
    Mod = 1000000007,
    Pow = pow(2, N, Mod),
    (Pow - 2) rem Mod.

pow(_, 0, _) -> 1;
pow(Base, Exp, Mod) when Exp rem 2 == 0 ->
    Half = pow(Base, Exp div 2, Mod),
    (Half * Half) rem Mod;
pow(Base, Exp, Mod) ->
    (Base * pow(Base, Exp - 1, Mod)) rem Mod.