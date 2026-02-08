-module(gcd_array).
-export([greatest_common_divisor/1]).

gcd(A, 0) -> A;
gcd(0, B) -> B;
gcd(A, B) -> gcd(B, A rem B).

greatest_common_divisor(Nums) ->
    lists:foldl(fun(Num, Acc) -> gcd(Num, Acc) end, lists:nth(1, Nums), lists:nthtail(1, Nums)).