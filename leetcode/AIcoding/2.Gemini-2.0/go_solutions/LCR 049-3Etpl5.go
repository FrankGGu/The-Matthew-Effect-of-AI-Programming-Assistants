func sumNumbers(root *TreeNode) int {
	var sum int

	var dfs func(*TreeNode, int)

	dfs = func(node *TreeNode, current int) {
		if node == nil {
			return
		}

		current = current*10 + node.Val

		if node.Left == nil && node.Right == nil {
			sum += current
			return
		}

		dfs(node.Left, current)
		dfs(node.Right, current)
	}

	dfs(root, 0)
	return sum
}