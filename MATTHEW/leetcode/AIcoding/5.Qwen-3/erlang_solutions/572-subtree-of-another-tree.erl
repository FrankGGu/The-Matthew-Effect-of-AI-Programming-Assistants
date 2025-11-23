-module(solution).
-export([is_subtree/2]).

is_subtree(Null, _) when Null =:= null -> true;
is_subtree(_, Null) when Null =:= null -> false;
is_subtree(T, S) ->
    case is_same_tree(T, S) of
        true -> true;
        _ -> is_subtree(T#tree.left, S) orelse is_subtree(T#tree.right, S)
    end.

is_same_tree(null, null) -> true;
is_same_tree(null, _) -> false;
is_same_tree(_, null) -> false;
is_same_tree(T, S) ->
    T#tree.val == S#tree.val andalso is_same_tree(T#tree.left, S#tree.left) andalso is_same_tree(T#tree.right, S#tree.right).