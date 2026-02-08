/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func maxSumBST(root *TreeNode) int {
    maxSum := 0
    var dfs func(node *TreeNode) (int, int, int, bool)
    dfs = func(node *TreeNode) (int, int, int, bool) {
        if node == nil {
            return 0, math.MaxInt32, math.MinInt32, true
        }
        leftSum, leftMin, leftMax, leftValid := dfs(node.Left)
        rightSum, rightMin, rightMax, rightValid := dfs(node.Right)

        if leftValid && rightValid && leftMax < node.Val && node.Val < rightMin {
            sum := leftSum + rightSum + node.Val
            if sum > maxSum {
                maxSum = sum
            }
            minVal := min(leftMin, node.Val)
            maxVal := max(rightMax, node.Val)
            return sum, minVal, maxVal, true
        }
        return 0, 0, 0, false
    }
    dfs(root)
    return maxSum
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}