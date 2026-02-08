-module(solution).
-export([is_subtree/2]).

-record(tree, {val, left = none, right = none}).

is_subtree(Tree1, Tree2) ->
    case Tree2 of
        none -> true;
        _ -> contains(Tree1, Tree2)
    end.

contains(Tree1, Tree2) ->
    case Tree1 of
        none -> false;
        _ -> is_same(Tree1, Tree2) orelse contains(Tree1#tree.left, Tree2) orelse contains(Tree1#tree.right, Tree2)
    end.

is_same(Tree1, Tree2) ->
    case {Tree1, Tree2} of
        {none, none} -> true;
        {none, _} -> false;
        {_, none} -> false;
        {T1, T2} -> T1#tree.val =:= T2#tree.val andalso is_same(T1#tree.left, T2#tree.left) andalso is_same(T1#tree.right, T2#tree.right)
    end.