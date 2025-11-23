-module(solution).
-export([canMeasureWater/3]).

canMeasureWater(X, Y, Z) ->
    if
        Z == 0 ->
            true;
        X + Y < Z ->
            false;
        true ->
            GCD = math:gcd(X, Y),
            Z rem GCD == 0
    end.