-record(treeNode, {val = 0 :: integer(),
                   left = null  :: 'null' | #treeNode{},
                   right = null :: 'null' | #treeNode{}}).

-spec is_subtree(Root :: #treeNode{} | null, SubRoot :: #treeNode{} | null) -> boolean().
is_subtree(null, _) -> false;
is_subtree(Root, SubRoot) ->
    is_same_tree(Root, SubRoot) orelse
    is_subtree(Root#treeNode.left, SubRoot) orelse
    is_subtree(Root#treeNode.right, SubRoot).

-spec is_same_tree(S :: #treeNode{} | null, T :: #treeNode{} | null) -> boolean().
is_same_tree(null, null) -> true;
is_same_tree(#treeNode{}, null) -> false;
is_same_tree(null, #treeNode{}) -> false;
is_same_tree(S, T) ->
    S#treeNode.val =:= T#treeNode.val andalso
    is_same_tree(S#treeNode.left, T#treeNode.left) andalso
    is_same_tree(S#treeNode.right, T#treeNode.right).