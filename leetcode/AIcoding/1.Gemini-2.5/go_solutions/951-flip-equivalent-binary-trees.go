func flipEquiv(root1 *TreeNode, root2 *TreeNode) bool {
    if root1 == nil && root2 == nil {
        return true
    }
    if root1 == nil || root2 == nil || root1.Val != root2.Val {
        return false
    }

    // Option 1: No flip at current node
    // Check if (root1.Left is equivalent to root2.Left) AND (root1.Right is equivalent to root2.Right)
    noFlipEquivalent := flipEquiv(root1.Left, root2.Left) && flipEquiv(root1.Right, root2.Right)

    // Option 2: Flip at current node
    // Check if (root1.Left is equivalent to root2.Right) AND (root1.Right is equivalent to root2.Left)
    flipEquivalent := flipEquiv(root1.Left, root2.Right) && flipEquiv(root1.Right, root2.Left)

    return noFlipEquivalent || flipEquivalent
}