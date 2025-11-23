-module(maximum_sum_permutation).
-export([maximum_sum/2]).

maximum_sum(Nums, Requests) ->
  N = length(Nums),
  PrefixSum = lists:foldl(
    fun({Start, End}, Acc) ->
      update_prefix_sum(Acc, Start, End)
    end,
    lists:seq(1, N, 0),
    Requests
  ),
  SortedPrefixSum = lists:sort(PrefixSum),
  SortedNums = lists:sort(Nums),
  Sum = lists:foldl(
    fun({A, B}, Acc) ->
      Acc + A * B
    end,
    0,
    lists:zip(lists:reverse(SortedNums), lists:reverse(SortedPrefixSum))
  ),
  Sum rem (1000000000 + 7).

update_prefix_sum(PrefixSum, Start, End) ->
  update_prefix_sum_helper(PrefixSum, Start, End, 1).

update_prefix_sum_helper(PrefixSum, Start, End, Value) ->
  PrefixSum2 = lists:update_at(Start, lists:nth(Start, PrefixSum) + Value, PrefixSum),
  case End < length(PrefixSum) of
    true ->
      lists:update_at(End + 1, lists:nth(End + 1, PrefixSum) - Value, PrefixSum2);
    false ->
      PrefixSum2
  end.