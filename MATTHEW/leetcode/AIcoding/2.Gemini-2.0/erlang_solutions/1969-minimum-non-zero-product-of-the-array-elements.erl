-module(minimum_non_zero_product).
-export([minimum_non_zero_product/1]).

minimum_non_zero_product(P) ->
    N = 1 bsl P,
    Base = N - 2,
    Count = (N - 1) div 2,
    Mod = 1000000007,
    (power(Base, Count, Mod) * (N - 1)) rem Mod.

power(Base, Exp, Mod) ->
    power_helper(Base, Exp, 1, Mod).

power_helper(_, 0, Acc, _) ->
    Acc;
power_helper(Base, Exp, Acc, Mod) ->
    if Exp rem 2 == 0 ->
        power_helper((Base * Base) rem Mod, Exp div 2, Acc, Mod);
    true ->
        power_helper((Base * Base) rem Mod, Exp div 2, (Acc * Base) rem Mod, Mod)
    end.