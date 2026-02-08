-module(solution).
-export([minimize_xor/2]).

minimize_xor(X, Y) ->
    Z = X band Y,
    Z + (Y bxor Z).