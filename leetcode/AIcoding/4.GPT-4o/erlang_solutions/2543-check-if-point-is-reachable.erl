-module(solution).
-export([isReachable/2]).

isReachable(X, Y) ->
    gcd(X, Y) =:= 1.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).