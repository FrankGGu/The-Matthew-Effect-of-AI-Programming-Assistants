-module(nice_divisors).
-export([maxNiceDivisors/1]).

maxNiceDivisors(primeFactors) ->
    Mod = 1000000007,
    case primeFactors rem 3 of
        0 -> power(3, primeFactors div 3, Mod),
        1 -> (power(3, (primeFactors div 3) - 1, Mod) * 4) rem Mod,
        2 -> (power(3, primeFactors div 3, Mod) * 2) rem Mod
    end.

power(Base, Exp, Mod) ->
    power_helper(Base rem Mod, Exp, 1, Mod).

power_helper(Base, 0, Acc, _) ->
    Acc;
power_helper(Base, Exp, Acc, Mod) ->
    if Exp rem 2 == 0 ->
        power_helper((Base * Base) rem Mod, Exp div 2, Acc, Mod);
    true ->
        power_helper((Base * Base) rem Mod, Exp div 2, (Acc * Base) rem Mod, Mod)
    end.