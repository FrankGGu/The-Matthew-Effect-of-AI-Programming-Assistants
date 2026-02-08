-module(solution).
-export([count_complete_subarrays/1]).

count_complete_subarrays(Nums) ->
  count_complete_subarrays(Nums, length(Nums)).

count_complete_subarrays(Nums, N) ->
  count_complete_subarrays(Nums, 0, N, 0).

count_complete_subarrays(Nums, Start, N, Acc) ->
  if Start >= N then
    Acc
  else
    count_complete_subarrays(Nums, Start, N, Acc + count_complete_subarrays_from(Nums, Start, N, 0, sets:from_list(Nums), sets:new()))
  end.

count_complete_subarrays_from(Nums, Start, N, End, AllDistinct, DistinctSoFar) ->
  if End >= N then
    0
  else
    NewDistinctSoFar = sets:add_element(lists:nth(End + 1, Nums), DistinctSoFar),
    if sets:size(NewDistinctSoFar) == sets:size(AllDistinct) then
      1 + count_complete_subarrays_from(Nums, Start, N, End + 1, AllDistinct, NewDistinctSoFar)
    else
      count_complete_subarrays_from(Nums, Start, N, End + 1, AllDistinct, NewDistinctSoFar)
    end
  end.