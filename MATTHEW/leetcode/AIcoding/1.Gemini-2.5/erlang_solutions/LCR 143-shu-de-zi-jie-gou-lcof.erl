-module(solution).
-export([isSubstructure/2]).

-record(tree_node, {val, left, right}).

isSubstructure(null, _) ->
    false;
isSubstructure(_, null) ->
    false;
isSubstructure(A, B) ->
    doesTree1HaveTree2(A, B) orelse
    isSubstructure(A#tree_node.left, B) orelse
    isSubstructure(A#tree_node.right, B).

doesTree1HaveTree2(null, _) ->
    false;
doesTree1HaveTree2(_, null) ->
    true;
doesTree1HaveTree2(A, B) ->
    A#tree_node.val == B#tree_node.val andalso
    doesTree1HaveTree2(A#tree_node.left, B#tree_node.left) andalso
    doesTree1HaveTree2(A#tree_node.right, B#tree_node.right).