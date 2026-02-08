-module(delete_leaves).
-export([delete_leaves/2]).

delete_leaves(Tree, Target) ->
    delete_leaves_helper(Tree, Target).

delete_leaves_helper(null, _) ->
    null;
delete_leaves_helper({val, null, null}, Target) when val == Target ->
    null;
delete_leaves_helper({val, Left, Right}, Target) ->
    NewLeft = delete_leaves_helper(Left, Target),
    NewRight = delete_leaves_helper(Right, Target),
    case {NewLeft, NewRight} of
        {null, null} when val == Target ->
            null;
        _ ->
            {val, NewLeft, NewRight}
    end.