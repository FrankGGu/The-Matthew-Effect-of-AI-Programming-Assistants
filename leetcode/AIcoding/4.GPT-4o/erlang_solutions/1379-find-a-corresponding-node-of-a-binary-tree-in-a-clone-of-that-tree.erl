-module(solution).
-export([get_target_copy/3]).

-record(node, {val, left = null, right = null}).

get_target_copy(Original, Cloned, Target) ->
    find_node(Original, Cloned, Target).

find_node(null, null, _) -> null;
find_node(OriginalNode, ClonedNode, Target) ->
    case OriginalNode of
        #node{val=Val} when Val =:= Target#node.val ->
            ClonedNode;
        _ ->
            case find_node(OriginalNode#node.left, ClonedNode#node.left, Target) of
                null -> find_node(OriginalNode#node.right, ClonedNode#node.right, Target);
                Result -> Result
            end
    end.