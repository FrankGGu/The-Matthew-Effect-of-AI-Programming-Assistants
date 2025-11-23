-module(solution).
-export([remove_leaf_nodes/2]).

remove_leaf_nodes(null, _Target) ->
    null;
remove_leaf_nodes({node, Val, Left, Right}, Target) ->
    NewLeft = remove_leaf_nodes(Left, Target),
    NewRight = remove_leaf_nodes(Right, Target),

    if
        NewLeft == null andalso NewRight == null andalso Val == Target ->
            null;
        true ->
            {node, Val, NewLeft, NewRight}
    end.