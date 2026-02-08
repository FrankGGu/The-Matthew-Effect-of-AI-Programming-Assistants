package main


func maxPoints(root *TreeNode) int {
    var dfs func(*TreeNode) [2]int
    dfs = func(node *TreeNode) [2]int {
        if node == nil {
            return [2]int{0, 0}
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        take := node.Val + left[1] + right[1]
        notTake := max(left[0], left[1]) + max(right[0], right[1])
        return [2]int{take, notTake}
    }
    res := dfs(root)
    return max(res[0], res[1])
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}