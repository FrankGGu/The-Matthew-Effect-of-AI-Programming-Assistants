-spec inorder_traversal(Root :: #tree_node{} | null) -> [integer()].
inorder_traversal(null) -> [];
inorder_traversal(Root) ->
    inorder_traversal(Root#tree_node.left) ++ 
    [Root#tree_node.val] ++ 
    inorder_traversal(Root#tree_node.right).