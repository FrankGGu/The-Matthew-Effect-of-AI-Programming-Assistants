-module(max_non_overlapping_subarrays).
-export([maxNonOverlapping/2]).

maxNonOverlapping(Nums, Target) ->
  maxNonOverlapping(Nums, Target, 0, 0, lists:new()).

maxNonOverlapping([], _Target, Count, _CurrentSum, _Seen) ->
  Count;
maxNonOverlapping(Nums, Target, Count, _CurrentSum, Seen) ->
  maxNonOverlapping(Nums, Target, 0, 0, lists:new(), Count, Seen).

maxNonOverlapping([], _Target, _CurrentSum, _Seen, Count, AccCount, AccSeen) ->
  AccCount;
maxNonOverlapping([H|T], Target, CurrentSum, Seen, Count, AccCount, AccSeen) ->
  NewSum = CurrentSum + H,
  case (NewSum == Target) orelse lists:member(NewSum - Target, [0|AccSeen]) of
    true ->
      maxNonOverlapping(T, Target, 0, lists:new(), Count+1, AccCount, [NewSum|AccSeen]);
    false ->
      maxNonOverlapping(T, Target, NewSum, [NewSum|Seen], Count, AccCount, AccSeen)
  end.