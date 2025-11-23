func isUnivalTree(root *TreeNode) bool {
    if root == nil {
        return true
    }
    val := root.Val
    var dfs func(*TreeNode) bool
    dfs = func(node *TreeNode) bool {
        if node == nil {
            return true
        }
        if node.Val != val {
            return false
        }
        return dfs(node.Left) && dfs(node.Right)
    }
    return dfs(root)
}