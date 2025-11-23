-module(solution).
-export([flip_equiv/2]).

-record(tree, {val, left = null, right = null}).

flip_equiv(null, null) ->
    true;
flip_equiv(null, _) ->
    false;
flip_equiv(_, null) ->
    false;
flip_equiv(Tree1, Tree2) ->
    Val1 = Tree1#tree.val,
    Val2 = Tree2#tree.val,
    (Val1 =:= Val2) andalso (
        (flip_equiv(Tree1#tree.left, Tree2#tree.left) andalso flip_equiv(Tree1#tree.right, Tree2#tree.right)) orelse
        (flip_equiv(Tree1#tree.left, Tree2#tree.right) andalso flip_equiv(Tree1#tree.right, Tree2#tree.left))
    ).