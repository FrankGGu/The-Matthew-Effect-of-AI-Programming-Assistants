-module(good_array).
-export([gcd/2, solve/1]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

solve([H|T]) ->
  lists:foldl(fun(X, Acc) -> gcd(Acc, X) end, H, T) == 1.