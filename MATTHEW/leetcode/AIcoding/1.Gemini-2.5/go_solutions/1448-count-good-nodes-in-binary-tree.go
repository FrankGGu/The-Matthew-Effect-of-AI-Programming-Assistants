package main

import "math"

func goodNodes(root *TreeNode) int {
	var dfs func(node *TreeNode, maxValSoFar int) int
	dfs = func(node *TreeNode, maxValSoFar int) int {
		if node == nil {
			return 0
		}

		count := 0
		if node.Val >= maxValSoFar {
			count = 1
		}

		newMaxValSoFar := max(maxValSoFar, node.Val)

		count += dfs(node.Left, newMaxValSoFar)
		count += dfs(node.Right, newMaxValSoFar)

		return count
	}

	return dfs(root, math.MinInt32)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}