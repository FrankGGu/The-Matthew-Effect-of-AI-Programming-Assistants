func deepestLeavesSum(root *TreeNode) int {
	maxDepth := -1
	currentSum := 0

	var dfs func(node *TreeNode, depth int)
	dfs = func(node *TreeNode, depth int) {
		if node == nil {
			return
		}

		if depth > maxDepth {
			maxDepth = depth
			currentSum = 0
		}

		if depth == maxDepth {
			if node.Left == nil && node.Right == nil {
				currentSum += node.Val
			}
		}

		dfs(node.Left, depth+1)
		dfs(node.Right, depth+1)
	}

	dfs(root, 0)
	return currentSum
}