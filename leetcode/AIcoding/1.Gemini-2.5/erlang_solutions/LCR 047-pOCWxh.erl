-module(solution).
-export([pruneTree/1]).

-record(tree_node, {val = 0, left = null, right = null}).

pruneTree(null) ->
    null;
pruneTree(#'tree_node'{val = Val, left = Left, right = Right}) ->
    PrunedLeft = pruneTree(Left),
    PrunedRight = pruneTree(Right),

    case Val == 1 orelse PrunedLeft /= null orelse PrunedRight /= null of
        true ->
            #'tree_node'{val = Val, left = PrunedLeft, right = PrunedRight};
        false ->
            null
    end.