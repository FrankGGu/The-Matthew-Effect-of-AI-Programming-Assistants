-module(minimize_maximum_pair_sum).
-export([min_pair_sum/1]).

min_pair_sum(Nums) ->
  Sorted = lists:sort(Nums),
  min_pair_sum_helper(Sorted, 1, hd(Sorted) + lists:last(Sorted)).

min_pair_sum_helper([], _, Max) ->
  Max;
min_pair_sum_helper([H|T], Count, Max) ->
  Len = length([H|T]);
  PairSum = H + lists:nth(Len - Count + 1, [H|T]);
  NewMax = max(Max, PairSum);
  min_pair_sum_helper(T, Count + 1, NewMax).