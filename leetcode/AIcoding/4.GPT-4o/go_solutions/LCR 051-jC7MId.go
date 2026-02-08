/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func maxPathSum(root *TreeNode) int {
    maxSum := math.MinInt64
    var helper func(node *TreeNode) int
    helper = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := max(helper(node.Left), 0)
        right := max(helper(node.Right), 0)
        maxSum = max(maxSum, node.Val+left+right)
        return node.Val + max(left, right)
    }
    helper(root)
    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}