package main

import "math"

type TreeNode struct {
	Val int
	Left *TreeNode
	Right *TreeNode
}

var maxSum int

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func dfs(node *TreeNode) int {
	if node == nil {
		return 0
	}

	leftGain := max(0, dfs(node.Left))
	rightGain := max(0, dfs(node.Right))

	currentPathSum := node.Val + leftGain + rightGain
	maxSum = max(maxSum, currentPathSum)

	return node.Val + max(leftGain, rightGain)
}

func maxPathSum(root *TreeNode) int {
	maxSum = math.MinInt32
	dfs(root)
	return maxSum
}