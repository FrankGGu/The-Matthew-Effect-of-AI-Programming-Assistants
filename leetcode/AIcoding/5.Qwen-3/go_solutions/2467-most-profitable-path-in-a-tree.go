package main


func profitablePath(root *TreeNode, k int) int {
    var dfs func(node *TreeNode, count map[int]int) map[int]int
    dfs = func(node *TreeNode, count map[int]int) map[int]int {
        if node == nil {
            return make(map[int]int)
        }
        if node.Left == nil && node.Right == nil {
            res := make(map[int]int)
            res[node.Val] = 1
            return res
        }
        left := dfs(node.Left, count)
        right := dfs(node.Right, count)
        res := make(map[int]int)
        for key, val := range left {
            res[key+node.Val] = val
        }
        for key, val := range right {
            res[key+node.Val] = val
        }
        return res
    }
    m := dfs(root, make(map[int]int))
    maxProfit := 0
    for key, val := range m {
        if key > maxProfit {
            maxProfit = key
        }
    }
    return maxProfit
}