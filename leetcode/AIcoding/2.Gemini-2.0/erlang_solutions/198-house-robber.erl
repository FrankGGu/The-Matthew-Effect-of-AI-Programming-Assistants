-module(house_robber).
-export([rob/1]).

rob(Nums) ->
  rob_helper(Nums, 0, 0).

rob_helper([], Rob1, Rob2) ->
  max(Rob1, Rob2);
rob_helper([H|T], Rob1, Rob2) ->
  NewRob1 = Rob2 + H,
  NewRob2 = max(Rob1, Rob2),
  rob_helper(T, NewRob1, NewRob2).

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.