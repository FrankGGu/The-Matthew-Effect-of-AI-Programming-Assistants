-module(maximum_distance).
-export([max_distance/2]).

max_distance(Nums1, Nums2) ->
  max_distance_helper(Nums1, Nums2, 0, 0, 0).

max_distance_helper(Nums1, Nums2, I, J, MaxDist) ->
  case {I < length(Nums1), J < length(Nums2)} of
    {true, true} ->
      case Nums1 !! I =< Nums2 !! J of
        true ->
          NewMaxDist = max(MaxDist, J - I);
          max_distance_helper(Nums1, Nums2, I, J + 1, NewMaxDist);
        false ->
          max_distance_helper(Nums1, Nums2, I + 1, J, MaxDist)
      end;
    {true, false} ->
      MaxDist;
    {false, _} ->
      MaxDist
  end.

length(List) ->
  length(List, 0).

length([], Acc) ->
  Acc;
length([_|T], Acc) ->
  length(T, Acc + 1).

max(A, B) ->
  if A > B -> A;
     true -> B
  end.