-module(good_nodes).
-export([good_nodes/1]).

good_nodes(Root) ->
  good_nodes_helper(Root, -infinity).

good_nodes_helper(null, _) ->
  0;
good_nodes_helper(Node, Max) ->
  Val = element(1, Node),
  Left = element(2, Node),
  Right = element(3, Node),
  NewMax = max(Val, Max),
  case Val >= Max of
    true ->
      1 + good_nodes_helper(Left, NewMax) + good_nodes_helper(Right, NewMax);
    false ->
      good_nodes_helper(Left, NewMax) + good_nodes_helper(Right, NewMax)
  end.

-spec max(number(), number()) -> number().
max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.