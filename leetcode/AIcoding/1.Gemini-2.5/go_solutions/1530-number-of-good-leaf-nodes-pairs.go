var totalPairs int

func countPairs(root *TreeNode, distance int) int {
	totalPairs = 0
	dfs(root, distance)
	return total