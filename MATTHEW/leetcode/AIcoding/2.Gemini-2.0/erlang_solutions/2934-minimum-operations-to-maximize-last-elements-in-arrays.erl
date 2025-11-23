-module(minimum_operations).
-export([min_operations/2]).

min_operations(Nums1, Nums2) ->
  N = length(Nums1),
  Last1 = lists:last(Nums1),
  Last2 = lists:last(Nums2),

  case check(Nums1, Nums2, N, Last1, Last2) of
    {inf, inf} -> -1;
    {A, B} -> min(A, B)
  end.

check(Nums1, Nums2, N, Last1, Last2) ->
  check_helper(Nums1, Nums2, N, Last1, Last2, 0, 0).

check_helper(Nums1, Nums2, N, Last1, Last2, Count1, Count2) ->
  case N of
    0 -> {Count1, Count2};
    _ ->
      H1 = hd(Nums1),
      H2 = hd(Nums2),
      T1 = tl(Nums1),
      T2 = tl(Nums2),

      case true of
        H1 =< Last1 and H2 =< Last2 ->
          check_helper(T1, T2, N - 1, Last1, Last2, Count1, Count2);
        H1 =< Last2 and H2 =< Last1 ->
          check_helper(T1, T2, N - 1, Last1, Last2, Count1 + 1, Count2 + 1);
        H1 =< Last1 and H2 > Last2 ->
          check_helper(T1, T2, N - 1, Last1, Last2, inf, Count2 + 1);
        H1 > Last1 and H2 =< Last2 ->
          check_helper(T1, T2, N - 1, Last1, Last2, Count1 + 1, inf);
        true ->
          {inf, inf}
      end
  end.