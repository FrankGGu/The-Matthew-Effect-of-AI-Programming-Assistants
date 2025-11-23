-module(array_partition).
-export([array_pair_sum/1]).

array_pair_sum(Nums) ->
  SortedNums = lists:sort(Nums),
  array_pair_sum_helper(SortedNums, 0).

array_pair_sum_helper([], Acc) ->
  Acc;
array_pair_sum_helper([A, B | Rest], Acc) ->
  array_pair_sum_helper(Rest, Acc + A).