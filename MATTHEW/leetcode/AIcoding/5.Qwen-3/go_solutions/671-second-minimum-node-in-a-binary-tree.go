package main


func findSecondMinimumNode(root *TreeNode) int {
	var result int = -1
	var dfs func(*TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			return
		}
		if result == -1 || node.Val < result {
			result = node.Val
		}
		dfs(node.Left)
		dfs(node.Right)
	}
	dfs(root)
	return result
}