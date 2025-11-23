-module(solution).
-export([max_nice_divisors/1]).

max_nice_divisors(1) -> 1;
max_nice_divisors(2) -> 2;
max_nice_divisors(3) -> 3;
max_nice_divisors(4) -> 4;
max_nice_divisors(PrimeFactors) ->
    Mod = 1000000007,
    Q = PrimeFactors div 3,
    R = PrimeFactors rem 3,
    if
        R == 0 -> pow(3, Q, Mod);
        R == 1 -> (pow(3, Q - 1, Mod) * 4) rem Mod;
        R == 2 -> (pow(3, Q, Mod) * 2) rem Mod
    end.

pow(_, 0, _) -> 1;
pow(A, B, Mod) ->
    Pow = pow(A, B div 2, Mod),
    PowSq = (Pow * Pow) rem Mod,
    if
        B rem 2 == 0 -> PowSq;
        true -> (PowSq * A) rem Mod
    end.