package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func collectCoins(root *TreeNode) int {
	if root == nil {
		return 0
	}

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
		return left + right
	}

	steps := dfs(root)
	return steps * 2
}