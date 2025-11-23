package main

import "math"

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func goodNodes(root *TreeNode) int {
    return countGoodNodes(root, math.MinInt)
}

func countGoodNodes(node *TreeNode, maxVal int) int {
    if node == nil {
        return 0
    }

    goodCount := 0
    if node.Val >= maxVal {
        goodCount = 1
        maxVal = node.Val
    }

    goodCount += countGoodNodes(node.Left, maxVal)
    goodCount += countGoodNodes(node.Right, maxVal)

    return goodCount
}