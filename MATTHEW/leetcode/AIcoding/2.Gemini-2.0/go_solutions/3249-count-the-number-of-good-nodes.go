func goodNodes(root *TreeNode) int {
    count := 0
    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, maxVal int) {
        if node == nil {
            return
        }
        if node.Val >= maxVal {
            count++
            maxVal = node.Val
        }
        dfs(node.Left, maxVal)
        dfs(node.Right, maxVal)
    }
    dfs(root, root.Val)
    return count
}