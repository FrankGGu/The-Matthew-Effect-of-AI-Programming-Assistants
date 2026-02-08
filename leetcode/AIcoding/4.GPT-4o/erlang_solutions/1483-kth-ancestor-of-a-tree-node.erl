-module(tree_ancestor).
-export([Ancestor/3]).

-record(node, {val, left = none, right = none}).

Ancestor(Root, K, Node) ->
    AncestorHelper(Root, K, Node, 0).

AncestorHelper(none, _, _, _) -> -1;
AncestorHelper(Node, K, Node, Depth) when Depth =:= K -> Node#node.val;
AncestorHelper(Node, K, Node, Depth) -> -1;
AncestorHelper(Node, K, TargetNode, Depth) ->
    LeftResult = AncestorHelper(Node#node.left, K, TargetNode, Depth + 1),
    case LeftResult of
        -1 -> AncestorHelper(Node#node.right, K, TargetNode, Depth + 1);
        _ -> LeftResult
    end.