-module(solution).
-export([xor_sum_all_pairs_bitwise_and/2]).

xor_sum_all_pairs_bitwise_and(Arr1, Arr2) ->
    XorSumA = lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Arr1),
    XorSumB = lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Arr2),
    XorSumA band XorSumB.