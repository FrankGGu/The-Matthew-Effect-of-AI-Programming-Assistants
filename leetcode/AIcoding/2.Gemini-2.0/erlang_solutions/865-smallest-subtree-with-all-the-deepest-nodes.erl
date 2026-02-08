-module(smallest_subtree_deepest).
-export([subtree_with_all_deepest/1]).

-record(node, {val, left, right}).

subtree_with_all_deepest(Root) ->
    {_, Node} = deepest(Root, 0),
    Node.

deepest(null, Depth) ->
    {Depth, null};
deepest(#node{val=Val, left=Left, right=Right}, Depth) ->
    {LeftDepth, LeftNode} = deepest(Left, Depth + 1),
    {RightDepth, RightNode} = deepest(Right, Depth + 1),
    case LeftDepth > RightDepth of
        true -> {LeftDepth, LeftNode};
        false ->
            case RightDepth > LeftDepth of
                true -> {RightDepth, RightNode};
                false -> {LeftDepth, #node{val=Val, left=Left, right=Right}}
            end
    end.