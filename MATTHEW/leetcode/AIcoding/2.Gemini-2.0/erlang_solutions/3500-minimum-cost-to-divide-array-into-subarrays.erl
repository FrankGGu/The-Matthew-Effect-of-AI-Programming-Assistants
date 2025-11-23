-module(minimum_cost_to_divide_array).
-export([minimum_cost/2]).

minimum_cost(Nums, K) ->
  N = length(Nums),
  Memo = dict:new(),
  minimum_cost_helper(Nums, 0, N - 1, K, Memo).

minimum_cost_helper(Nums, L, R, K, Memo) ->
  Key = {L, R},
  case dict:find(Key, Memo) of
    {ok, Value} ->
      Value;
    error ->
      Result = calculate_minimum_cost(Nums, L, R, K, Memo),
      dict:store(Key, Result, Memo),
      Result
  end.

calculate_minimum_cost(Nums, L, R, K, Memo) ->
  if L > R ->
    0;
  true ->
    Cost = length(lists:usort(lists:sublist(Nums, L + 1, R - L + 1))) + K,
    Best = lists:foldl(fun(I, Acc) ->
      min(Acc, minimum_cost_helper(Nums, L, I, K, Memo) + minimum_cost_helper(Nums, I + 1, R, K, Memo))
    end, infinity, lists:seq(L, R - 1)),
    min(Cost, Best)
  end.