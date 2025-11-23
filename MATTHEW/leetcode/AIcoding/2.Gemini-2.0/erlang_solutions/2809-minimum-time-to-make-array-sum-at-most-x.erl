-module(minimum_time).
-export([minimum_time/2]).

minimum_time(Nums1, Nums2) ->
    minimum_time(Nums1, Nums2, 0, length(Nums1), -1).

minimum_time(Nums1, Nums2, X, N, Ans) ->
    case possible(Nums1, Nums2, X, N) of
        true ->
            case Ans =:= -1 of
                true ->
                    minimum_time(Nums1, Nums2, X - 1, N, X);
                false ->
                    minimum_time(Nums1, Nums2, X - 1, N, min(Ans, X))
            end;
        false ->
            case X >= 2000 of
                true ->
                    Ans;
                false ->
                  case Ans =:= -1 of
                      true ->
                          minimum_time(Nums1, Nums2, X + 1, N, -1);
                      false ->
                          Ans
                  end
            end
    end.

possible(Nums1, Nums2, Time, N) ->
  lists:sort([ {Nums2 !! I, Nums1 !! I} || I <- lists:seq(0, N - 1)]),
  possible(lists:sort([ {Nums2 !! I, Nums1 !! I} || I <- lists:seq(0, N - 1)]), Time, 0, 0, N).

possible([], _Time, _Sum, _Sum2, _N) ->
  true;
possible(List, Time, Sum, Sum2, N) ->
  PossibleList = lists:sublist(List,1,min(length(List),N)),

  lists:foldl(
    fun({_B,A}, Acc) -> Acc + A end,
    0,
    PossibleList
  ) + Sum2 + Time * lists:foldl(
    fun({B,_A}, Acc) -> Acc + B end,
    0,
    PossibleList
  ) =< Sum.