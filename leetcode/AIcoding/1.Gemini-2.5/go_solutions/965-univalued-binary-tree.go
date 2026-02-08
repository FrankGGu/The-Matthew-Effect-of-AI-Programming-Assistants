func isUnivalTree(root *TreeNode) bool {
	if root == nil {
		return true
	}

	val := root.Val

	var dfs func(node *TreeNode, expectedVal int) bool
	dfs = func(node *TreeNode, expectedVal int) bool {
		if node == nil {
			return true
		}

		if node.Val != expectedVal {
			return false
		}

		return dfs(node.Left, expectedVal) && dfs(node.Right, expectedVal)
	}

	return dfs(root, val)
}