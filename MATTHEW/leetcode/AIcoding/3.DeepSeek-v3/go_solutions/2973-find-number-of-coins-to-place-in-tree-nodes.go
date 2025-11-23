type TreeNode struct {
    Val int
    Left *TreeNode
    Right *TreeNode
}

func placeCoins(root *TreeNode) []int {
    res := make([]int, 0)
    var dfs func(node *TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        total := left + right + node.Val
        coins := total - 1
        res = append(res, abs(coins))
        return total
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