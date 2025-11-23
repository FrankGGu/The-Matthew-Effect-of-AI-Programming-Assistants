-module(solution).
-export([countGoodNumbers/1]).

-define(MOD, 1000000007).

pow_mod(Base, Exp, Mod) when Exp == 0 -> 1;
pow_mod(Base, Exp, Mod) ->
    HalfRes = pow_mod(Base, Exp div 2, Mod),
    SquaredRes = (HalfRes * HalfRes) rem Mod,
    case Exp rem 2 of
        0 -> SquaredRes;
        1 -> (SquaredRes * Base) rem Mod
    end.

countGoodNumbers(N) ->
    EvenCount = (N + 1) div 2,
    OddCount = N div 2,

    ResultEven = pow_mod(5, EvenCount, ?MOD),
    ResultOdd = pow_mod(4, OddCount, ?MOD),

    (ResultEven * ResultOdd) rem ?MOD.