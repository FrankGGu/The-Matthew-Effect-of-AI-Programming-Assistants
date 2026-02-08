-module(solution).
-export([gcd_pairs/2]).

gcd_pairs(N, Queries) ->
    G = lists:map(fun({X, Y}) -> gcd(X, Y) end, Queries),
    lists:map(fun(X) -> {X, lists:filter(fun(Y) -> Y rem X == 0 end, G)} end, lists:seq(1, N)).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).