-module(min_non_zero_product).
-export([minNonZeroProduct/1]).

minNonZeroProduct(N) ->
    Mod = 1000000007,
    Max = N - 1,
    Power = (N - 1) * (N - 1),
    Result = pow(1, Power, Mod),
    (Result * (1 + (N - 1) * (N - 1) - 1)) rem Mod.

pow(_, 0, _) -> 1;
pow(Base, Exp, Mod) when Exp rem 2 == 0 ->
    T = pow(Base, Exp div 2, Mod),
    (T * T) rem Mod;
pow(Base, Exp, Mod) ->
    (Base * pow(Base, Exp - 1, Mod)) rem Mod.