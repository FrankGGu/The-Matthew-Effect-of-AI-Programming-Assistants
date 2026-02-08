package main


func maxPathSum(root *TreeNode) int {
    maxSum := -1 << 63
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := max(0, dfs(node.Left))
        right := max(0, dfs(node.Right))
        current := node.Val + left + right
        maxSum = max(maxSum, current)
        return node.Val + max(left, right)
    }
    dfs(root)
    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}