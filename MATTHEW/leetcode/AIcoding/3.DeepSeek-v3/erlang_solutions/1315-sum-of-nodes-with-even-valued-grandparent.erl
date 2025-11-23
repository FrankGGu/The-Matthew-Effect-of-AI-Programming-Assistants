-spec sum_even_grandparent(Root :: #tree_node{} | null) -> integer().
sum_even_grandparent(Root) ->
    traverse(Root, null, null).

traverse(null, _, _)
    -> 0;
traverse(Node, Parent, Grandparent)
    when Grandparent =/= null, Grandparent#tree_node.val rem 2 == 0
    -> Node#tree_node.val + traverse(Node#tree_node.left, Node, Parent) + traverse(Node#tree_node.right, Node, Parent);
traverse(Node, Parent, Grandparent)
    -> traverse(Node#tree_node.left, Node, Parent) + traverse(Node#tree_node.right, Node, Parent).