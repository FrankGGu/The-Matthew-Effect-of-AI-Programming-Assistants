-module(solution).
-export([is_reachable/4]).

is_reachable(X1, Y1, X2, Y2) ->
    gcd(X2 - X1, Y2 - Y1) =:= gcd(X1, Y1).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).