func isBalanced(root *TreeNode) bool {
    // A helper function that returns the height of the subtree rooted at 'node'
    // if it's balanced. If the subtree is unbalanced, it returns -1.
    var checkBalance func(node *TreeNode) int
    checkBalance = func(node *TreeNode) int {
        if node == nil {
            return 0 // An empty tree has height 0 and is balanced
        }

        leftHeight := checkBalance(node.Left)
        if leftHeight == -1 {
            return -1 // Left subtree is unbalanced, so the whole tree is unbalanced
        }

        rightHeight := checkBalance(node.Right)
        if rightHeight == -1 {
            return -1 // Right subtree is unbalanced, so the whole tree is unbalanced
        }

        // Check if the current node itself is balanced based on its children's heights
        diff := leftHeight - rightHeight
        if diff < 0 {
            diff = -diff // abs(diff)
        }
        if diff > 1 {
            return -1 // The heights of left and right subtrees differ by more than 1
        }

        // If balanced, return the height of the current subtree
        if leftHeight > rightHeight {
            return leftHeight + 1
        }
        return rightHeight + 1
    }

    return checkBalance(root) != -1
}