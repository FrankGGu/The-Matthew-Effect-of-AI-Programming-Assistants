package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func distributeCoins(root *TreeNode) int {
	var moves int
	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		left := dfs(node.Left)
		right := dfs(node.Right)
		moves += abs(left) + abs(right)
		return left + right + node.Val - 1
	}
	dfs(root)
	return moves
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}