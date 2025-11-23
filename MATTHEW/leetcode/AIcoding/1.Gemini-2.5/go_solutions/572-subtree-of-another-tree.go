func isSubtree(root *TreeNode, subRoot *TreeNode) bool {
    if root == nil {
        return false
    }

    // Check if the tree rooted