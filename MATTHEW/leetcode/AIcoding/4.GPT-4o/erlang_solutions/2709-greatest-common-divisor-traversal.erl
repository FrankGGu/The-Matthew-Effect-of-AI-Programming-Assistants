-module(solution).
-export([gcd_traversal/1]).

gcd_traversal(N) ->
    Lists = lists:seq(1, N),
    GCDs = lists:map(fun(X) -> gcd(X, N) end, Lists),
    lists:usort(GCDs).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).