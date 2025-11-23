-module(solution).
-export([get_target_copy/3]).

-record(tree_node, {val, left, right}).

get_target_copy(_, _, _) ->
    undefined.

get_target_copy(Clone, Target, Node) ->
    get_target_copy(Clone, Target, Node, 0).

get_target_copy(_, _, _, 1) ->
    undefined;
get_target_copy(Clone, Target, Node, Depth) ->
    case Clone of
        {tree_node, Val, Left, Right} when Val == Node#tree_node.val ->
            case Left of
                undefined ->
                    case Right of
                        undefined ->
                            if Val == Target#tree_node.val -> Clone;
                               true -> get_target_copy(Left, Target, Node, Depth + 1)
                            end;
                        _ -> get_target_copy(Right, Target, Node, Depth + 1)
                    end;
                _ -> get_target_copy(Left, Target, Node, Depth + 1)
            end;
        _ -> 
            case Left of
                undefined ->
                    case Right of
                        undefined -> undefined;
                        _ -> get_target_copy(Right, Target, Node, Depth + 1)
                    end;
                _ -> get_target_copy(Left, Target, Node, Depth + 1)
            end
    end.