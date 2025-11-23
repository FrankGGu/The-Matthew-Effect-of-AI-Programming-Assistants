func averageOfSubtree(root *TreeNode) int {
	count := 0
	var dfs func(*TreeNode) (int, int)
	dfs = func(node *TreeNode) (int, int) {
		if node == nil {
			return 0, 0
		}
		sumLeft, countLeft := dfs(node.Left)
		sumRight, countRight := dfs(node.Right)
		totalSum := sumLeft + sumRight + node.Val
		totalCount := countLeft + countRight + 1
		if totalSum/totalCount == node.Val {
			count++
		}
		return totalSum, totalCount
	}
	dfs(root)
	return count
}