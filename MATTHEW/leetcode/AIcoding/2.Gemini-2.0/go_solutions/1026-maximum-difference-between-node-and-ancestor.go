func maxAncestorDiff(root *TreeNode) int {
	maxDiff := 0
	var dfs func(node *TreeNode, maxVal, minVal int)
	dfs = func(node *TreeNode, maxVal, minVal int) {
		if node == nil {
			return
		}
		maxVal = max(maxVal, node.Val)
		minVal = min(minVal, node.Val)
		maxDiff = max(maxDiff, maxVal-minVal)
		dfs(node.Left, maxVal, minVal)
		dfs(node.Right, maxVal, minVal)
	}
	dfs(root, root.Val, root.Val)
	return maxDiff
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}