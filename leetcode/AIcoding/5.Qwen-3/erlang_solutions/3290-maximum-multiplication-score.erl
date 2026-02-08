-module(maximum_multiplication_score).
-export([maxMultiply/2]).

maxMultiply(Nums1, Nums2) ->
    Max = lists:max([lists:sum([lists:nth(I, Nums1) * lists:nth(J, Nums2) || I <- lists:seq(1, length(Nums1)), J <- lists:seq(1, length(Nums2))])]),
    Max.