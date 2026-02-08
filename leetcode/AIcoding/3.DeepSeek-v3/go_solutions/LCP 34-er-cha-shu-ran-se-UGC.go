/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func maxValue(root *TreeNode, k int) int {
    var dfs func(*TreeNode) []int
    dfs = func(node *TreeNode) []int {
        dp := make([]int, k+1)
        if node == nil {
            return dp
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        dp[0] = max(left) + max(right)
        for i := 1; i <= k; i++ {
            for j := 0; j < i; j++ {
                dp[i] = max(dp[i], left[j] + right[i-1-j] + node.Val)
            }
        }
        return dp
    }
    return max(dfs(root))
}

func max(arr []int) int {
    res := 0
    for _, v := range arr {
        if v > res {
            res = v
        }
    }
    return res
}