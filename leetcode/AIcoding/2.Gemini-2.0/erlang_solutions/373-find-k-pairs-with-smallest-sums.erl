-module(find_k_pairs).
-export([k_smallest_pairs/3]).

k_smallest_pairs(Nums1, Nums2, K) ->
  k_smallest_pairs(Nums1, Nums2, K, []).

k_smallest_pairs(Nums1, Nums2, K, Acc) ->
  case {Nums1, Nums2} of
    {[], _} -> lists:reverse(Acc);
    {_, []} -> lists:reverse(Acc);
    {[_|_], [_|_]} ->
      SortedPairs =
        lists:sort(fun({A1, A2}, {B1, B2}) -> A1 + A2 < B1 + B2 end,
          [{X, Y} || X <- Nums1, Y <- Nums2]),
      Take = min(K, length(SortedPairs)),
      lists:sublist(SortedPairs, Take).
  end.