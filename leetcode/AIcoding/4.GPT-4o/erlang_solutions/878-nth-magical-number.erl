-module(solution).
-export([nth_magical_number/3]).

nth_magical_number(N, A, B) ->
    L = lcm(A, B),
    K = N * A * B div L,
    M = N * (A + B) - K div (A + B),
    M rem 1000000007.

lcm(X, Y) ->
    (X * Y) div gcd(X, Y).

gcd(X, 0) -> X;
gcd(X, Y) -> gcd(Y, X rem Y).