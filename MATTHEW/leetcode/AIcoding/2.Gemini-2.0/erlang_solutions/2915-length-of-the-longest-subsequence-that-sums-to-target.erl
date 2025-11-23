-module(longest_subsequence_sum_target).
-export([length_of_longest_subsequence_that_sums_to_target/2]).

length_of_longest_subsequence_that_sums_to_target(Nums, Target) ->
  length_of_longest_subsequence_that_sums_to_target(Nums, Target, 0, 0, []).

length_of_longest_subsequence_that_sums_to_target([], Target, CurrentSum, Count, Subsequence) ->
  if CurrentSum == Target then
    length(Subsequence)
  else
    -1
  end;
length_of_longest_subsequence_that_sums_to_target([H|T], Target, CurrentSum, Count, Subsequence) ->
  Include = length_of_longest_subsequence_that_sums_to_target(T, Target, CurrentSum + H, Count + 1, [H|Subsequence]),
  Exclude = length_of_longest_subsequence_that_sums_to_target(T, Target, CurrentSum, Count, Subsequence),
  if Include > Exclude then
    Include
  else
    Exclude
  end.