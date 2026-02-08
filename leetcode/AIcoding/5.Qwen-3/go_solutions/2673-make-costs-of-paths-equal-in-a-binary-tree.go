package main


func minIncrements(root *TreeNode) int {
    var res int
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        res += abs(left - right)
        return node.Val + max(left, right)
    }
    dfs(root)
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}