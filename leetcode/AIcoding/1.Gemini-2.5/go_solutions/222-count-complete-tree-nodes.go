func countNodes(root *TreeNode) int {
    if root == nil {
        return 0
    }

    // Function to calculate the height of the tree by traversing the leftmost