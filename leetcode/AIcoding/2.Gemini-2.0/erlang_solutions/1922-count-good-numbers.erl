-module(count_good_numbers).
-export([count_good_numbers/1]).

count_good_numbers(N) ->
    Mod = 1000000007,
    ProductOdds = power(5, (N + 1) div 2, Mod),
    ProductEvens = power(4, N div 2, Mod),
    (ProductOdds * ProductEvens) rem Mod.

power(Base, Exp, Mod) ->
    power_helper(Base rem Mod, Exp, 1, Mod).

power_helper(Base, 0, Acc, _Mod) ->
    Acc;
power_helper(Base, Exp, Acc, Mod) ->
    if Exp rem 2 == 0 ->
        power_helper((Base * Base) rem Mod, Exp div 2, Acc, Mod);
    true ->
        power_helper(Base, Exp - 1, (Acc * Base) rem Mod, Mod)
    end.