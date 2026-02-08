-module(find_k_pairs).
-export([k_smallest_pairs/3]).

k_smallest_pairs(Nums1, Nums2, K) ->
    N1 = length(Nums1),
    N2 = length(Nums2),
    Pairs = [{Nums1!!I, Nums2!!J} || I <- lists:seq(0, min(N1 - 1, K - 1)), J <- lists:seq(0, min(N2 - 1, K - 1))],
    SortedPairs = lists:keysort(fun({A, B}) -> A + B end, Pairs),
    lists:sublist(SortedPairs, 1, min(K, length(SortedPairs))).