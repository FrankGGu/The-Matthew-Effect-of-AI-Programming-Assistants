-module(solution).
-export([find_gcd/1]).

find_gcd(Numbers) ->
    lists:foldl(fun(X, Acc) -> gcd(X, Acc) end, hd(Numbers), tl(Numbers)).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).