-module(largest_sum_subsequence).
-export([max_subsequence/2]).

max_subsequence(Nums, K) ->
  {SortedNums, _} = lists:sortwith(fun(A, B) -> A > B end, lists:zip(Nums, lists:seq(1, length(Nums)))),
  Indices = [Index || {_Num, Index} <- lists:sublist(SortedNums, 1, K)],
  lists:sort(Indices, fun(A, B) -> A < B end),
  [Nums !! (Index - 1) || Index <- Indices].