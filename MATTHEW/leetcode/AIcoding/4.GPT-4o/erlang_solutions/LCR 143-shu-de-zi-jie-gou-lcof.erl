-module(solution).
-export([is_sub_structure/2]).

-record(node, {val, left = null, right = null}).

is_sub_structure(Tree1, Tree2) ->
    case Tree1 of
        null -> false;
        _ -> is_sub_structure_helper(Tree1, Tree2) orelse is_sub_structure(Tree1#node.left, Tree2) orelse is_sub_structure(Tree1#node.right, Tree2)
    end.

is_sub_structure_helper(null, null) -> true;
is_sub_structure_helper(null, _) -> false;
is_sub_structure_helper(_, null) -> false;
is_sub_structure_helper(Tree1, Tree2) ->
    Tree1#node.val =:= Tree2#node.val oand 
    is_sub_structure_helper(Tree1#node.left, Tree2#node.left) oand 
    is_sub_structure_helper(Tree1#node.right, Tree2#node.right).