func sumOfLeftLeaves(root *TreeNode) int {
    if root == nil {
        return 0
    }

    sum := 0

    // Check if the left child is a leaf
    if root.Left != nil {
        if root.Left.Left == nil && root.Left.Right == nil {
            sum += root.Left.Val
        } else {
            // If not a leaf, recurse on the left subtree
            sum += sumOfLeftLeaves(root.Left)
        }
    }

    // Always recurse on the right subtree
    sum += sumOfLeftLeaves(root.Right)

    return sum
}