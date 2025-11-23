-module(btree_pruning).
-export([prune_tree/1]).

-prune_tree(Node) when is_tuple(Node) ->
    Left = element(2, Node),
    Right = element(3, Node),
    NewLeft = prune_tree(Left),
    NewRight = prune_tree(Right),
    if
        element(1, Node) == 0, NewLeft == null, NewRight == null -> null;
        true -> {element(1, Node), NewLeft, NewRight}
    end;
-prune_tree(null) -> null.