package main

func countPairs(root *TreeNode, k int) int {
    var result int
    var dfs func(node *TreeNode) []int
    dfs = func(node *TreeNode) []int {
        if node == nil {
            return []int{}
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        res := []int{1}
        for _, l := range left {
            for _, r := range right {
                if l+r <= k {
                    result++
                }
            }
        }
        for _, l := range left {
            res = append(res, l+1)
        }
        for _, r := range right {
            res = append(res, r+1)
        }
        return res
    }
    dfs(root)
    return result
}

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}