-module(max_sum_non_adjacent).
-export([rob/1]).

rob(Nums) ->
  rob_helper(Nums, 0, 0).

rob_helper([], Include, Exclude) ->
  max(Include, Exclude);
rob_helper([H|T], Include, Exclude) ->
  New_Include = Exclude + H,
  New_Exclude = max(Include, Exclude),
  rob_helper(T, New_Include, New_Exclude).

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.