-module(solution).
-export([countGoodNumbers/1]).

-define(MOD, 1_000_000_007).

power(Base, Exp, Mod) when Exp == 0 -> 1;
power(Base, Exp, Mod) when Exp rem 2 == 0 ->
    Half = power(Base, Exp div 2, Mod),
    (Half * Half) rem Mod;
power(Base, Exp, Mod) ->
    (Base * power(Base, Exp - 1, Mod)) rem Mod.

countGoodNumbers(N) ->
    NumEvenPositions = (N + 1) div 2,
    NumOddPositions = N div 2,

    PowerOf4 = power(4, NumOddPositions + 1, ?MOD),
    PowerOf5 = power(5, NumEvenPositions - 1, ?MOD),

    (PowerOf4 * PowerOf5) rem ?MOD.