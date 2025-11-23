-module(first_missing_positive).
-export([first_missing_positive/1]).

first_missing_positive(Nums) ->
  N = length(Nums),
  Nums1 = lists:map(fun(X) -> if X =< 0 or X > N then 1 else X end, Nums),
  Nums2 = lists:foldl(fun(X, Acc) ->
    Index = abs(X) - 1,
    if Index < N then
      case lists:nth(Index + 1, Acc) of
        Y when Y > 0 -> lists:replace(Index + 1, -Y, Acc);
        _ -> Acc
      end
    else
      Acc
    end
  end, Nums1, Nums1),
  first_missing_positive_helper(Nums2, 1).

first_missing_positive_helper(Nums, Index) ->
  case lists:nth(Index, Nums) of
    X when X > 0 -> Index;
    _ ->
      if Index =:= length(Nums) then
        Index + 1
      else
        first_missing_positive_helper(Nums, Index + 1)
      end
  end.