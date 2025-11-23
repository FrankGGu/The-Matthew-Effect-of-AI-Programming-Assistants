package main


func maxAncestorDiff(root *TreeNode) int {
	var dfs func(*TreeNode, int, int) int
	dfs = func(node *TreeNode, minVal int, maxVal int) int {
		if node == nil {
			return maxVal - minVal
		}
		newMin := min(minVal, node.Val)
		newMax := max(maxVal, node.Val)
		left := dfs(node.Left, newMin, newMax)
		right := dfs(node.Right, newMin, newMax)
		return max(left, right)
	}
	return dfs(root, root.Val, root.Val)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}