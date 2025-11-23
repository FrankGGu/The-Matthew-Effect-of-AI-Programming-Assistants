func findFrequentTreeSum(root *TreeNode) []int {
	if root == nil {
		return []int{}
	}

	sumCounts := make(map[int]int)
	maxFreq := 0

	var dfs func(node *TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}

		leftSum := dfs(node.Left)
		rightSum := dfs(node.Right)

		currentSum := node.Val + leftSum + rightSum
		sumCounts[currentSum]++

		if sumCounts[currentSum] > maxFreq {
			maxFreq = sumCounts[currentSum]
		}
		return currentSum
	}

	dfs(root)

	var result []int
	for sum, count := range sumCounts {
		if count == maxFreq {
			result = append(result, sum)
		}
	}

	return result
}