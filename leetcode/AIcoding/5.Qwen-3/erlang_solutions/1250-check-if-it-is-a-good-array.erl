-module(solution).
-export([is_good_array/1]).

is_good_array(Nums) ->
    lists:foldl(fun(X, Acc) -> gcd(Acc, X) end, hd(Nums), tl(Nums)) == 1.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).