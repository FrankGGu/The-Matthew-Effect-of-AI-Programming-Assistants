var totalMoves int

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func dfs(node *TreeNode) int {
	if node == nil {
		return 0
	}

	leftBalance := dfs(node.Left)
	rightBalance := dfs(node.Right)

	totalMoves += abs(leftBalance) + abs(rightBalance)

	return node.Val - 1 + leftBalance + rightBalance
}

func distributeCoins(root *TreeNode) int {
	totalMoves = 0
	dfs(root)
	return totalMoves
}