package main


func timeTakenToMarkAllNodes(root *TreeNode) int {
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
		return 1 + max(left, right)
	}

	return dfs(root)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}