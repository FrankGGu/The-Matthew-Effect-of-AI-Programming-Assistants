/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

type SubTreeInfo struct {
    IsBST bool
    Min   int
    Max   int
    Sum   int
}

func maxSumBST(root *TreeNode) int {
    maxSum := 0
    var dfs func(*TreeNode) SubTreeInfo
    dfs = func(node *TreeNode) SubTreeInfo {
        if node == nil {
            return SubTreeInfo{true, math.MaxInt32, math.MinInt32, 0}
        }
        left := dfs(node.Left)
        right := dfs(node.Right)

        if left.IsBST && right.IsBST && node.Val > left.Max && node.Val < right.Min {
            sum := node.Val + left.Sum + right.Sum
            if sum > maxSum {
                maxSum = sum
            }
            minVal := min(node.Val, left.Min)
            maxVal := max(node.Val, right.Max)
            return SubTreeInfo{true, minVal, maxVal, sum}
        }
        return SubTreeInfo{false, 0, 0, 0}
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