package main


func minTimeToCollectAllApples(root *TreeNode) int {
	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		left := dfs(node.Left)
		right := dfs(node.Right)
		if node.Val == 1 || left > 0 || right > 0 {
			return left + right + 2
		}
		return 0
	}
	return dfs(root)
}