-module(solution).
-export([isSubtree/2]).

isSubtree(S, T) ->
    isSubtree_impl(S, T).

isSubtree_impl(nil, _) -> false;
isSubtree_impl(S, T) ->
    is_same_tree(S, T) orelse
    isSubtree_impl(element(2, S), T) orelse
    isSubtree_impl(element(3, S), T).

is_same_tree(nil, nil) -> true;
is_same_tree(nil, _) -> false;
is_same_tree(_, nil) -> false;
is_same_tree({Val1, Left1, Right1}, {Val2, Left2, Right2}) ->
    Val1 == Val2 andalso
    is_same_tree(Left1, Left2) andalso
    is_same_tree(Right1, Right2).