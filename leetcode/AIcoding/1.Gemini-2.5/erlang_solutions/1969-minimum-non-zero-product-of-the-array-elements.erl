-module(solution).
-export([minNonZeroProduct/1]).

minNonZeroProduct(P) ->
    Mod = 1000000007,

    if P == 0 ->
        1;
    true ->
        % Calculate (2^P - 1) mod Mod
        % This is the value of one element in the optimal configuration.
        Val1 = (power(2, P, Mod) - 1 + Mod) rem Mod,

        % Calculate (2^P - 2) mod Mod
        % This is the value of other elements in the optimal configuration.
        Val2 = (power(2, P, Mod) - 2 + Mod) rem Mod,

        % Calculate exponent: (2^(P-1) - 1)
        % This is the number of times Val2 appears in the product.
        % The exponent needs to be calculated modulo (Mod - 1) due to Fermat's Little Theorem.
        Exp = (power(2, P - 1, Mod - 1) - 1 + (Mod - 1)) rem (Mod - 1),

        % Calculate (Val2 ^ Exp) mod Mod
        PowVal2 = power(Val2, Exp, Mod),

        % Final product: (Val1 * PowVal2) mod Mod
        (Val1 * PowVal2) rem Mod
    end.

power(_, 0, Mod) -> 1;
power(Base, Exp, Mod) ->
    if Exp rem 2 == 0 ->
        Half = power(Base, Exp div 2, Mod),
        (Half * Half) rem Mod;
    true ->
        (Base * power(Base, Exp - 1, Mod)) rem Mod
    end.