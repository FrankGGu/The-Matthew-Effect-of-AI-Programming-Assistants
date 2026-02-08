package main

import (
	"sort"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

var perfectSizes []int

func dfs(node *TreeNode) (height int, isPerfect bool) {
	if node == nil {
		return -1, true
	}

	leftHeight, leftIsPerfect := dfs(node.Left)
	rightHeight, rightIsPerfect := dfs(node.Right)

	if !leftIsPerfect || !rightIsPerfect || leftHeight != rightHeight {
		return -1, false
	}

	currentHeight := leftHeight + 1
	currentSize := (1 << (currentHeight + 1)) - 1

	perfectSizes = append(perfectSizes, currentSize)

	return currentHeight, true
}

func kthLargestPerfectSubtreeSize(root *TreeNode, k int) int {
	perfectSizes = []int{}

	dfs(root)

	sort.Slice(perfectSizes, func(i, j int) bool {
		return perfectSizes[i] > perfectSizes[j]
	})

	if k > len(perfectSizes) {
		return -1 
	}

	return perfectSizes[k-1]
}