-module(good_nodes).
-export([good_nodes/1]).

good_nodes(Root) ->
  good_nodes(Root, -infinity).

good_nodes(null, _) ->
  0;
good_nodes(Node, MaxSoFar) ->
  case Node of
    #{val := Val, left := Left, right := Right} ->
      NewMax = max(Val, MaxSoFar),
      (if Val >= MaxSoFar then 1 else 0 end) +
        good_nodes(Left, NewMax) +
        good_nodes(Right, NewMax)
  end.