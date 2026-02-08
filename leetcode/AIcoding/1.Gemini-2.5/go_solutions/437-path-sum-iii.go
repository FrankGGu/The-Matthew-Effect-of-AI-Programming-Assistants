func pathSum(root *TreeNode, targetSum int) int {
	if root == nil {
		return 0
	}

	var count int

	var dfs func(node *TreeNode, currentPathSum int)
	dfs = func(node *TreeNode, currentPathSum int) {
		if node == nil {
			return
		}

		currentPathSum += node.Val
		if currentPathSum == targetSum {
			count++
		}

		dfs(node.Left, currentPathSum)
		dfs(node.Right, currentPathSum)
	}

	var traverse func(node *TreeNode)
	traverse = func(node *TreeNode) {
		if node == nil {
			return
		}

		dfs(node, 0)

		traverse(node.Left)
		traverse(node.Right)
	}

	traverse(root)

	return count
}