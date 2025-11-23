package main

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

var maxSum int

func maxPathSum(root *TreeNode) int {
    maxSum = root.Val
    dfs(root)
    return maxSum
}

func dfs(node *TreeNode) int {
    if node == nil {
        return 0
    }
    left := max(0, dfs(node.Left))
    right := max(0, dfs(node.Right))
    current := node.Val + left + right
    if current > maxSum {
        maxSum = current
    }
    return node.Val + max(left, right)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}