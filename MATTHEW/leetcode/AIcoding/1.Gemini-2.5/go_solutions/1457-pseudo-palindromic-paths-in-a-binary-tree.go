func pseudoPalindromicPaths(root *TreeNode) int {
	count := 0

	var dfs func(node *TreeNode, pathMask int)
	dfs = func(node *TreeNode, pathMask int) {
		if node == nil {
			return
		}

		pathMask ^= (1 << node.Val)

		if node.Left == nil && node.Right == nil {
			// Leaf node reached
			// Check if pathMask has 0 or 1 bits set
			if (pathMask & (pathMask - 1)) == 0 {
				count++
			}
			return
		}

		dfs(node.Left, pathMask)
		dfs(node.Right, pathMask)
	}

	dfs(root, 0)
	return count
}