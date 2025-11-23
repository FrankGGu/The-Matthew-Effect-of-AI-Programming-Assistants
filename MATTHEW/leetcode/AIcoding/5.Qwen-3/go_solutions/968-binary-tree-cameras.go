package main


func minCameraCover(root *TreeNode) int {
	var count int
	var dfs func(node *TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 2
		}
		left := dfs(node.Left)
		right := dfs(node.Right)
		if left == 0 || right == 0 {
			count++
			return 1
		}
		if left == 1 || right == 1 {
			return 2
		}
		return 0
	}
	if dfs(root) == 0 {
		count++
	}
	return count
}