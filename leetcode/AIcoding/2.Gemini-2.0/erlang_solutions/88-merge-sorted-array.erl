-module(merge_sorted_array).
-export([merge/3]).

merge(Nums1, M, Nums2) ->
  merge(Nums1, M, Nums2, 0, []).

merge(Nums1, M, Nums2, N, Acc) ->
  case N of
    M ->
      lists:reverse(Acc) ++ lists:sublist(Nums2, 1, length(Nums2));
    _ ->
      case Nums1 of
        [] ->
          lists:reverse(Acc) ++ lists:sublist(Nums2, 1, length(Nums2));
        [H1|T1] ->
          case Nums2 of
            [] ->
              lists:reverse(Acc) ++ lists:sublist([H1|T1], 1, M - N);
            [H2|T2] ->
              if
                H1 =< H2 ->
                  merge(T1, M, Nums2, N + 1, [H1 | Acc]);
                true ->
                  merge(Nums1, M, T2, N, [H2 | Acc])
              end
          end
      end
  end.