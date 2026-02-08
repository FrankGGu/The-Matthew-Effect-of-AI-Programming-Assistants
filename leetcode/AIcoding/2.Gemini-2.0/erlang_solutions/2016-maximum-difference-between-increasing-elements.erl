-module(maximum_difference).
-export([maximum_difference/1]).

maximum_difference(Nums) ->
  maximum_difference_helper(Nums, hd(Nums), -1).

maximum_difference_helper([], _, MaxDiff) ->
  MaxDiff;
maximum_difference_helper([H|T], MinSoFar, MaxDiff) ->
  case H > MinSoFar of
    true ->
      NewMaxDiff = max(MaxDiff, H - MinSoFar),
      maximum_difference_helper(T, MinSoFar, NewMaxDiff);
    false ->
      NewMinSoFar = min(MinSoFar, H),
      maximum_difference_helper(T, NewMinSoFar, MaxDiff)
  end.