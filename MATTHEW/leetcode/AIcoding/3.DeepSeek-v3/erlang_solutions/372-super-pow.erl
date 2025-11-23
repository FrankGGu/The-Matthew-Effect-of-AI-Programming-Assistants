-module(super_pow).
-export([super_pow/2]).

super_pow(A, B) ->
    Mod = 1337,
    Pow = lists:foldl(fun(Digit, Acc) -> pow_mod(Acc, 10, Mod) * pow_mod(A, Digit, Mod) rem Mod end, 1, B),
    Pow.

pow_mod(_A, 0, _Mod) -> 1;
pow_mod(A, 1, Mod) -> A rem Mod;
pow_mod(A, B, Mod) ->
    Half = pow_mod(A, B div 2, Mod),
    case B rem 2 of
        0 -> (Half * Half) rem Mod;
        1 -> (Half * Half rem Mod) * (A rem Mod) rem Mod
    end.