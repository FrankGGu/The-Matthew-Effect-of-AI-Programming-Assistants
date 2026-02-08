-module(solution).
-export([xor_all_pairings/2]).

xor_all_pairings(Nums1, Nums2) ->
    N = length(Nums1),
    M = length(Nums2),

    XorSum1 = lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, Nums1),
    XorSum2 = lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, Nums2),

    case {N rem 2, M rem 2} of
        {0, 0} -> 0;
        {0, 1} -> XorSum1;
        {1, 0} -> XorSum2;
        {1, 1} -> XorSum1 bxor XorSum2
    end.