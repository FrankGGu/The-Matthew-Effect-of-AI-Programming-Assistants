func sufficientSubset(root *TreeNode, limit int) *TreeNode {
    var dfs func(*TreeNode, int) bool
    dfs = func(node *TreeNode, sum int) bool {
        if node == nil {
            return false
        }
        if node.Left == nil && node.Right == nil {
            return node.Val+sum >= limit
        }
        leftSufficient := dfs(node.Left, sum+node.Val)
        rightSufficient := dfs(node.Right, sum+node.Val)
        if !leftSufficient {
            node.Left = nil
        }
        if !rightSufficient {
            node.Right = nil
        }
        return leftSufficient || rightSufficient
    }
    if !dfs(root, 0) {
        return nil
    }
    return root
}