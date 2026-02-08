-module(kth_smallest_product).
-export([kth_smallest_product/3]).

kth_smallest_product(Nums1, Nums2, K) ->
  L = -10000000000,
  R = 10000000000,
  binary_search(Nums1, Nums2, K, L, R).

binary_search(Nums1, Nums2, K, L, R) ->
  if L =< R then
    Mid = L + (R - L) div 2,
    if count_less_equal(Nums1, Nums2, Mid) < K then
      binary_search(Nums1, Nums2, K, Mid + 1, R)
    else
      binary_search(Nums1, Nums2, K, L, Mid - 1)
    end
  else
    L
  end.

count_less_equal(Nums1, Nums2, Mid) ->
  count_less_equal(Nums1, Nums2, Mid, 0).

count_less_equal([], _, _, Acc) ->
  Acc;
count_less_equal([H1|T1], Nums2, Mid, Acc) ->
  count_less_equal(T1, Nums2, Mid, Acc + count_less_equal_row(Nums2, Mid, H1, 0)).

count_less_equal_row([], _, _, _) ->
  0;
count_less_equal_row([H2|T2], Mid, Num1, Count) ->
  if Num1 * H2 =< Mid then
    count_less_equal_row(T2, Mid, Num1, Count + 1)
  else
    Count
  end.