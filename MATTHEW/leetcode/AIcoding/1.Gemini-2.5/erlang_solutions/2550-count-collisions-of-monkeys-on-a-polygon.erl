-module(solution).
-export([countCollisions/1]).

-define(MOD, 1000000007).

countCollisions(N) ->
    TwoPowN = power(2, N, ?MOD),
    (TwoPowN - 2 + ?MOD) rem ?MOD.

power(Base, Exp, Mod) ->
    power(Base, Exp, Mod, 1).

power(_, 0, _, Acc) ->
    Acc;
power(Base, Exp, Mod, Acc) ->
    if
        Exp rem 2 == 1 ->
            power((Base * Base) rem Mod, Exp div 2, Mod, (Acc * Base) rem Mod);
        true ->
            power((Base * Base) rem Mod, Exp div 2, Mod, Acc)
    end.