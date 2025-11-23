-module(solution).
-export([sumOfGoodNumbers/1]).

sumOfGoodNumbers(N) ->
    Mod = 1000000007,
    GoodCount = (N div 2) + 1,
    OddCount = N div 2,
    GoodNumbers = (mod(exp(10, GoodCount, Mod) - 1 + Mod, Mod) * exp(9, OddCount, Mod)) rem Mod,
    GoodNumbers.

exp(_, 0, _) -> 1;
exp(Base, Exponent, Mod) when Exponent > 0 ->
    case Exponent rem 2 of
        0 -> 
            (exp((Base * Base) rem Mod, Exponent div 2, Mod)) rem Mod;
        _ -> 
            (Base * exp(Base, Exponent - 1, Mod)) rem Mod
    end.