-module(solution).
-export([countGoodPairs/3]).

countGoodPairs(Nums1, Nums2, K) ->
    Count = [1 || N1 <- Nums1,
                  N2 <- Nums2,
                  N1 rem (N2 * K) == 0],
    length(Count).