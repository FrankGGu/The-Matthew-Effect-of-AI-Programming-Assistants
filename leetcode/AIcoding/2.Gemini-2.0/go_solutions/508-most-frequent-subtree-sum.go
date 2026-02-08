type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func findFrequentTreeSum(root *TreeNode) []int {
	sumCount := make(map[int]int)
	var maxCount int

	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		leftSum := dfs(node.Left)
		rightSum := dfs(node.Right)
		subtreeSum := node.Val + leftSum + rightSum
		sumCount[subtreeSum]++
		if sumCount[subtreeSum] > maxCount {
			maxCount = sumCount[subtreeSum]
		}
		return subtreeSum
	}

	dfs(root)

	var result []int
	for sum, count := range sumCount {
		if count == maxCount {
			result = append(result, sum)
		}
	}

	return result
}