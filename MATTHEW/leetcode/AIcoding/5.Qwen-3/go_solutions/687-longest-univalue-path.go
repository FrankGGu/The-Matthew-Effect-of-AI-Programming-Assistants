package main


func longestUnivaluePath(root *TreeNode) int {
	var maxPath int

	var dfs func(*TreeNode, int) int
	dfs = func(node *TreeNode, parentVal int) int {
		if node == nil {
			return 0
		}
		left := dfs(node.Left, node.Val)
		right := dfs(node.Right, node.Val)
		maxPath = max(maxPath, left+right)
		if node.Val == parentVal {
			return 1 + max(left, right)
		}
		return 0
	}

	dfs(root, 0)
	return maxPath
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}