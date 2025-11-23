package main

import "math"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func maxSumBST(root *TreeNode) int {
    maxSum := 0

    var dfs func(node *TreeNode) (int, int, int, bool)
    dfs = func(node *TreeNode) (int, int, int, bool) {
        if node == nil {
            return math.MaxInt32, math.MinInt32, 0, true
        }

        leftMin, leftMax, leftSum, isLeftBST := dfs(node.Left)
        rightMin, rightMax, rightSum, isRightBST := dfs(node.Right)

        if isLeftBST && isRightBST && node.Val > leftMax && node.Val < rightMin {
            sum := leftSum + rightSum + node.Val
            maxSum = max(maxSum, sum)
            return min(leftMin, node.Val), max(rightMax, node.Val), sum, true
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