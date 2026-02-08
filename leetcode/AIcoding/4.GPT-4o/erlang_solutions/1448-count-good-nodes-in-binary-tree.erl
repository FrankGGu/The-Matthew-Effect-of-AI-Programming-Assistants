-module(solution).
-export([good_nodes/1]).

-record(node, {val, left = none, right = none}).

good_nodes(Root) ->
    good_nodes_helper(Root, -inf).

good_nodes_helper(none, _) ->
    0;
good_nodes_helper(Node, Max) ->
    Val = Node#node.val,
    NewMax = max(Val, Max),
    GoodCount = if Val >= Max -> 1; true -> 0 end,
    GoodCount + good_nodes_helper(Node#node.left, NewMax) + good_nodes_helper(Node#node.right, NewMax).