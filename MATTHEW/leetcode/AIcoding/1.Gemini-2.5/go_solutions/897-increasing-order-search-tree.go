func increasingBST(root *TreeNode) *TreeNode {
    dummyHead := &TreeNode{}
    tail := dummyHead

    var inorder func(*TreeNode)
    inorder = func(node *TreeNode) {
        if node == nil {
            return
        }

        inorder(node.Left)

        // Process the current node
        node.Left = nil       // As per problem, each node has no left child
        tail.Right = node     // Link the previous node in the new list to the current node
        tail = node           // Move the tail pointer to the current node

        inorder(node.Right)
    }

    inorder(root)

    return dummyHead.Right
}