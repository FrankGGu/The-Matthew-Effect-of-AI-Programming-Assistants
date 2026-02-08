-module(count_good_numbers).
-export([countGoodNumbers/1]).

countGoodNumbers(N) ->
    Mod = 1000000007,
    GoodDigits = 15,
    Total = pow(GoodDigits, N, Mod),
    Total.

pow(_, 0, _) -> 1;
pow(Base, Exponent, Mod) ->
    case Exponent rem 2 of
        0 -> pow(Base * Base rem Mod, Exponent div 2, Mod);
        1 -> Base * pow(Base * Base rem Mod, Exponent div 2, Mod) rem Mod
    end.