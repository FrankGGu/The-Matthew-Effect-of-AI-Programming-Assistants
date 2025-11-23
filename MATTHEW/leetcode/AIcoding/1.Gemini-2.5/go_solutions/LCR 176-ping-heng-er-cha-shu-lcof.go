func isBalanced(root *TreeNode) bool {
    return getHeight(root) != -1
}

func getHeight(node *TreeNode) int {
    if node == nil {
        return 0
    }

    leftHeight := getHeight(node.Left)
    if leftHeight == -1 {
        return -1 // Left subtree is unbalanced
    }

    rightHeight := getHeight(node.Right)
    if rightHeight == -1 {
        return -1 // Right subtree is unbalanced
    }

    // Check if the current node is balanced
    if abs(leftHeight - rightHeight) > 1 {
        return -1
    }

    // If balanced, return the actual height of the current subtree
    return 1 + max(leftHeight, rightHeight)
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}