-module(solution).
-export([solve/3]).

-record('TreeNode', {val, left, right}).

solve(Root, N, X) ->
    XNode = find_node(Root, X),
    LeftSubtreeSize = get_subtree_size(XNode#'TreeNode'.left),
    RightSubtreeSize = get_subtree_size(XNode#'TreeNode'.right),
    ParentPartSize = N - (1 + LeftSubtreeSize + RightSubtreeSize),

    (LeftSubtreeSize * 2) > N orelse
    (RightSubtreeSize * 2) > N orelse
    (ParentPartSize * 2) > N.

find_node(nil, _TargetVal) ->
    nil;
find_node(#'TreeNode'{val = Val, left = Left, right = Right} = Node, TargetVal) ->
    if Val == TargetVal ->
        Node;
    true ->
        case find_node(Left, TargetVal) of
            nil -> find_node(Right, TargetVal);
            FoundNode -> FoundNode
        end
    end.

get_subtree_size(nil) ->
    0;
get_subtree_size(#'TreeNode'{val = _, left = Left, right = Right}) ->
    1 + get_subtree_size(Left) + get_subtree_size(Right).