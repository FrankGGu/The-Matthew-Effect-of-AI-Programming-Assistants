-module(solution).
-export([prune_tree/1]).

-prune_tree(Node) ->
    prune(Node).

prune(nil) ->
    nil;
prune(Node) ->
    {Val, Left, Right} = Node,
    LeftPruned = prune(Left),
    RightPruned = prune(Right),
    if
        Val == 0, LeftPruned == nil, RightPruned == nil ->
            nil;
        true ->
            {Val, LeftPruned, RightPruned}
    end.