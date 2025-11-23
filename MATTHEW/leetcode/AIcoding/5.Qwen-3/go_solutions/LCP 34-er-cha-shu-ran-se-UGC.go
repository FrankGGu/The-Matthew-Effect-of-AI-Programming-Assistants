package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func minimumCount(root *TreeNode) int {
	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		left := dfs(node.Left)
		right := dfs(node.Right)
		if left == 0 && right == 0 {
			return 1
		}
		if left == 0 {
			return right + 1
		}
		if right == 0 {
			return left + 1
		}
		return min(left, right) + 1
	}
	return dfs(root)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}