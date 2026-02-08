-module(min_difference).
-export([minimum_difference/2]).

minimum_difference(Nums, K) ->
  SortedNums = lists:sort(Nums),
  min_difference_helper(SortedNums, K, infinity).

min_difference_helper([H|T], K, MinDiff) when length([H|T]) < K ->
  MinDiff;
min_difference_helper([H|T], K, MinDiff) ->
  Diff = lists:nth(K - 1, [H|T]) - H,
  NewMinDiff = min(MinDiff, Diff),
  min_difference_helper(T, K, NewMinDiff);
min_difference_helper([], _, MinDiff) ->
  MinDiff.

min(A, B) ->
  if
    A < B -> A;
    true -> B
  end.