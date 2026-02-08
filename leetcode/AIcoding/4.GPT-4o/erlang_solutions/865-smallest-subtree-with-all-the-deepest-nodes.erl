-module(solution).
-export([subtree_with_all_deepest_nodes/1]).

-type tree() :: none | {Node, tree(), tree()}.

subtree_with_all_deepest_nodes(Tree) ->
    {Depth, Nodes} = deepest_nodes(Tree, 0, []),
    find_subtree(Tree, Nodes).

deepest_nodes(none, Depth, Nodes) ->
    {Depth, Nodes};
deepest_nodes({Node, Left, Right}, Depth, Nodes) ->
    {LeftDepth, LeftNodes} = deepest_nodes(Left, Depth + 1, []),
    {RightDepth, RightNodes} = deepest_nodes(Right, Depth + 1, []),
    case LeftDepth > RightDepth of
        true -> {LeftDepth, [Node | LeftNodes]};
        false -> case LeftDepth < RightDepth of
            true -> {RightDepth, [Node | RightNodes]};
            false -> {LeftDepth, [Node | LeftNodes ++ RightNodes]}
        end
    end.

find_subtree(none, _) -> none;
find_subtree({Node, Left, Right}, Nodes) ->
    case lists:member(Node, Nodes) of
        true -> {Node, find_subtree(Left, Nodes), find_subtree(Right, Nodes)};
        false -> none
    end.