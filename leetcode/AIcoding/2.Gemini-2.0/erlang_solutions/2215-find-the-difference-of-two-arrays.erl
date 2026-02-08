-module(find_difference).
-export([find_difference/2]).

find_difference(Nums1, Nums2) ->
  Set1 = sets:from_list(Nums1),
  Set2 = sets:from_list(Nums2),
  Diff1 = lists:usort([X || X <- Nums1, not lists:member(X, Nums2)]),
  Diff2 = lists:usort([X || X <- Nums2, not lists:member(X, Nums1)]),
  [Diff1, Diff2].