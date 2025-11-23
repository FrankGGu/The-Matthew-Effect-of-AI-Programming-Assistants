func countGoodNodes(root *TreeNode) int {
    var count int

    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, maxSoFar int) {
        if node == nil {
            return
        }

        if node.Val >= maxSoFar {
            count++
            maxSoFar = node.Val
        }

        dfs(node.Left, maxSoFar)
        dfs(node.Right, maxSoFar)
    }

    dfs(root, -10001)
    return count
}