-record(treeNode, {val = 0 :: integer(),
                  left = null  :: 'null' | #treeNode{},
                  right = null :: 'null' | #treeNode{}}).

-spec merge_trees(T1 :: #treeNode{} | null, T2 :: #treeNode{} | null) -> #treeNode{} | null.
merge_trees(null, null) -> null;
merge_trees(T1, null) -> T1;
merge_trees(null, T2) -> T2;
merge_trees(T1, T2) ->
    #treeNode{
        val = T1#treeNode.val + T2#treeNode.val,
        left = merge_trees(T1#treeNode.left, T2#treeNode.left),
        right = merge_trees(T1#treeNode.right, T2#treeNode.right)
    }.