-module(rob).
-export([rob/1]).

rob(Nums) ->
  rob_helper(Nums, 0, 0).

rob_helper([], Prev1, Prev2) ->
  max(Prev1, Prev2);
rob_helper([H | T], Prev1, Prev2) ->
  rob_helper(T, Prev2 + H, max(Prev1, Prev2)).

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.