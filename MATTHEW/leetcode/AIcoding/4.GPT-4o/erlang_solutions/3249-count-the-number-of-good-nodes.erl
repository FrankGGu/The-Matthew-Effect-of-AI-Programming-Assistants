-module(solution).
-export([good_nodes/1]).

-record(node, {val, left = undefined, right = undefined}).

good_nodes(Tree) ->
    case Tree of
        undefined -> 0;
        _ -> good_nodes_helper(Tree, Tree#node.val)
    end.

good_nodes_helper(undefined, _) -> 0;
good_nodes_helper(Node, Max) ->
    CurrentVal = Node#node.val,
    NewMax = max(CurrentVal, Max),
    GoodCount = if CurrentVal >= Max -> 1; true -> 0 end,
    GoodCount + good_nodes_helper(Node#node.left, NewMax) + good_nodes_helper(Node#node.right, NewMax).