-module(solution).
-export([prune_tree/1]).

-record(node, {val, left=none, right=none}).

prune_tree(Root) ->
    case prune(Root) of
        none -> none;
        Tree -> Tree
    end.

prune(none) -> none;
prune(#node{left=Left, right=Right} = Node) ->
    Left1 = prune(Left),
    Right1 = prune(Right),
    case {Left1, Right1} of
        {none, none} -> none;
        {Left1, Right1} -> #node{val = Node#node.val, left = Left1, right = Right1}
    end.