-module(solution).
-export([min_non_zero_product/1]).

min_non_zero_product(P) ->
    Mod = 1000000007,
    MaxNum = (1 bsl P) - 1,
    K = MaxNum bsr 1,
    Pow = fast_pow(MaxNum - 1, K, Mod),
    Result = (Pow * MaxNum) rem Mod,
    Result.

fast_pow(Base, Exp, Mod) ->
    fast_pow(Base, Exp, Mod, 1).

fast_pow(_, 0, _, Acc) -> Acc;
fast_pow(Base, Exp, Mod, Acc) when (Exp band 1) =:= 1 ->
    fast_pow((Base * Base) rem Mod, Exp bsr 1, Mod, (Acc * Base) rem Mod);
fast_pow(Base, Exp, Mod, Acc) ->
    fast_pow((Base * Base) rem Mod, Exp bsr 1, Mod, Acc).