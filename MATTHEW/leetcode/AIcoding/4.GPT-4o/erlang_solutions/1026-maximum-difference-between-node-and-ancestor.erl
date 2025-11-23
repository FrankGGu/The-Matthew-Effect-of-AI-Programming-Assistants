-module(solution).
-export([max_ancestor_diff/1]).

-record(node, {val, left = none, right = none}).

max_ancestor_diff(Root) when Root =/= none ->
    max_diff(Root, Root#node.val, Root#node.val);
max_ancestor_diff(_) ->
    0.

max_diff(none, _, _) ->
    0;
max_diff(Node, Min, Max) ->
    Val = Node#node.val,
    NewMin = min(Min, Val),
    NewMax = max(Max, Val),
    LeftDiff = max_diff(Node#node.left, NewMin, NewMax),
    RightDiff = max_diff(Node#node.right, NewMin, NewMax),
    max(LeftDiff, RightDiff, Max - Min).

min(X, Y) when X < Y -> X;
min(X, Y) -> Y.

max(X, Y) when X > Y -> X;
max(X, Y) -> Y.

max(X, Y, Z) -> max(max(X, Y), Z).