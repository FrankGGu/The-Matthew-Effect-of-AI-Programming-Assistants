-module(solution).
-export([gcd_of_array/1]).

gcd_of_array(Numbers) ->
    GCD = lists:foldl(fun(X, Acc) -> gcd(X, Acc) end, hd(Numbers), tl(Numbers)),
    GCD.

gcd(A, B) when A < B -> gcd(B, A);
gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).