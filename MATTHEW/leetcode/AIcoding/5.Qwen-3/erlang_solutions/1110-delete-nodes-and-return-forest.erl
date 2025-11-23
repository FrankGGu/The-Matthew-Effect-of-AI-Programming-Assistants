-module(solution).
-export([del_nodes/2]).

del_nodes(Root, To_Delete) ->
    ToDeleteSet = sets:from_list(To_Delete),
    {Result, _} = helper(Root, ToDeleteSet, true),
    Result.

helper(nil, _, _) ->
    {[], nil};
helper(Node, ToDeleteSet, IsRoot) ->
    [LeftNodes, LeftChild] = helper(Node#node.left, ToDeleteSet, false),
    [RightNodes, RightChild] = helper(Node#node.right, ToDeleteSet, false),
    case sets:is_element(Node#node.val, ToDeleteSet) of
        true ->
            {LeftNodes ++ RightNodes, nil};
        false ->
            Node#node{left = LeftChild, right = RightChild},
            if IsRoot ->
                {[Node | LeftNodes ++ RightNodes], Node};
               true ->
                {LeftNodes ++ RightNodes, Node}
            end
    end.