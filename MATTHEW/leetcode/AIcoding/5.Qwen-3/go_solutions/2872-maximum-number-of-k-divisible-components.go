package main


func numberOfKDivisibleComponents(root *TreeNode, k int) int {
    count := 0
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        sum := node.Val + dfs(node.Left) + dfs(node.Right)
        if sum%k == 0 {
            count++
        }
        return sum
    }
    dfs(root)
    return count
}