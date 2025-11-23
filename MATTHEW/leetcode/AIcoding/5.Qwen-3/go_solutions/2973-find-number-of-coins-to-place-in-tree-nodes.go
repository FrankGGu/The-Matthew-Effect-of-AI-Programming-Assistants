package main


func findNumberOfCoins(root *TreeNode) int {
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        return node.Val + left + right
    }
    return dfs(root)
}