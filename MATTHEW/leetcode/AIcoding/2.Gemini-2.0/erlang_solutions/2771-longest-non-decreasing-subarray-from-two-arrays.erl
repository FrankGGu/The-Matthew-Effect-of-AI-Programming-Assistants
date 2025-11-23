-module(longest_non_decreasing_subarray_from_two_arrays).
-export([find_length/3]).

find_length(Nums1, Nums2, N) ->
  find_length(Nums1, Nums2, N, 0, 0, 0, -1, -1).

find_length(_Nums1, _Nums2, 0, Len, _, _, _, _) ->
  Len;
find_length([H1|T1], [H2|T2], N, Len, Len1, Len2, Prev1, Prev2) ->
  NewLen1 =
    case
      true ->
        case
          (Prev1 == -1) orelse (H1 >= Prev1) ->
            Len1 + 1;
          true ->
            1
        end
    end,
  NewLen2 =
    case
      true ->
        case
          (Prev2 == -1) orelse (H1 >= Prev2) ->
            max(Len2 + 1,1);
          true ->
            1
        end
    end,
  NewLen3 =
    case
      true ->
        case
          (Prev1 == -1) orelse (H2 >= Prev1) ->
            max(Len1 + 1,1);
          true ->
            1
        end
    end,
  NewLen4 =
    case
      true ->
        case
          (Prev2 == -1) orelse (H2 >= Prev2) ->
            Len2 + 1;
          true ->
            1
        end
    end,
  find_length(T1, T2, N - 1, max(Len, max(NewLen1,NewLen4)), max(NewLen1,NewLen3), max(NewLen2,NewLen4), H1, H2).