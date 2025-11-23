-module(solution).
-export([xor_all_pairs/2]).

xor_all_pairs(Nums1, Nums2) ->
    lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, [A bxor B || A <- Nums1, B <- Nums2]).