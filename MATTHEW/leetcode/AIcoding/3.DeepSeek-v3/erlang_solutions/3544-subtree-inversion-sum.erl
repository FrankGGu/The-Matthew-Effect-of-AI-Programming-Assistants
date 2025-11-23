-module(solution).
-export([invert_subtree_sum/1]).

-spec invert_subtree_sum(Root :: null | {integer(), null | tuple(), null | tuple()}) -> integer().
invert_subtree_sum(null) -> 0;
invert_subtree_sum({Val, Left, Right}) ->
    Sum = Val + invert_subtree_sum(Left) + invert_subtree_sum(Right),
    NewLeft = invert_tree(Right),
    NewRight = invert_tree(Left),
    Sum + invert_subtree_sum(NewLeft) + invert_subtree_sum(NewRight).

invert_tree(null) -> null;
invert_tree({Val, Left, Right}) -> {Val, invert_tree(Right), invert_tree(Left)}.