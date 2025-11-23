func hasPathSum(root *TreeNode, targetSum int) bool {
    if root == nil {
        return false
    }

    // If it's a leaf node
    if root.Left == nil && root.Right == nil {
        return targetSum - root.Val == 0
    }

    // Recurse on left and right children
    // Subtract current node's value from targetSum
    leftPath := hasPathSum(root.Left, targetSum - root.Val)
    rightPath := hasPathSum(root.Right, targetSum - root.Val)

    return leftPath || rightPath
}