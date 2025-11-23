package main

import "math"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

var maxSum int

func maxPathSum(root *TreeNode) int {
    maxSum = math.MinInt32
    maxGain(root)
    return maxSum
}

func maxGain(node *TreeNode) int {
    if node == nil {
        return 0
    }

    leftGain := max(maxGain(node.Left), 0)
    rightGain := max(maxGain(node.Right), 0)

    priceNewPath := node.Val + leftGain + rightGain

    maxSum = max(maxSum, priceNewPath)

    return node.Val + max(leftGain, rightGain)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}