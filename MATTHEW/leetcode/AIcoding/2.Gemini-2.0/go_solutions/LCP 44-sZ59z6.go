func show(root *TreeNode) int {
    if root == nil {
        return 0
    }
    s := make(map[int]bool)
    var dfs func(*TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        s[node.Val] = true
        dfs(node.Left)
        dfs(node.Right)
    }
    dfs(root)
    return len(s)
}