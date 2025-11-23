-module(solution).
-export([maxNiceDivisors/1]).

maxNiceDivisors(PrimeFactors) when PrimeFactors =< 3 ->
    PrimeFactors;
maxNiceDivisors(PrimeFactors) ->
    Mod = 1000000007,
    Rem = PrimeFactors rem 3,
    Quo = PrimeFactors div 3,
    case Rem of
        0 ->
            power(3, Quo, Mod);
        1 ->
            (power(3, Quo - 1, Mod) * 4) rem Mod;
        2 ->
            (power(3, Quo, Mod) * 2) rem Mod
    end.

power(Base, Exp, Mod) ->
    power_acc(Base, Exp, 1, Mod).

power_acc(_, 0, Acc, _) -> Acc;
power_acc(Base, Exp, Acc, Mod) ->
    NewAcc = if Exp rem 2 == 1 -> (Acc * Base) rem Mod;
             else -> Acc
             end,
    NewBase = (Base * Base) rem Mod,
    power_acc(NewBase, Exp div 2, NewAcc, Mod).