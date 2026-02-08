var leftSubtreeSize int
var rightSubtreeSize int

func dfs(node *TreeNode, x int) int {
	if node == nil {
		return 0
	}

	leftCount := dfs(node.Left, x)
	rightCount := dfs(node.Right, x)

	if node.Val == x {
		leftSubtreeSize = leftCount
		rightSubtreeSize = rightCount
	}

	return 1 + leftCount + rightCount
}

func btreeGameWinningStrategy(root *TreeNode, n int, x int) bool {
	leftSubtreeSize = 0
	rightSubtreeSize = 0

	dfs(root, x)

	parentComponentSize := n - (1 + leftSubtreeSize + rightSubtreeSize)

	if leftSubtreeSize > n/2 || rightSubtreeSize > n/2 || parentComponentSize > n/2 {
		return true
	}

	return false
}