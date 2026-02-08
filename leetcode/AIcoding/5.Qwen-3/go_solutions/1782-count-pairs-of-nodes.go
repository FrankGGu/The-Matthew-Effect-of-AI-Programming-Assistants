package main


func countPairs(root *TreeNode, distance int) int {
	var count int

	var dfs func(*TreeNode) []int
	dfs = func(node *TreeNode) []int {
		if node == nil {
			return []int{}
		}
		if node.Left == nil && node.Right == nil {
			return []int{1}
		}

		left := dfs(node.Left)
		right := dfs(node.Right)

		for _, l := range left {
			for _, r := range right {
				if l+r <= distance {
					count++
				}
			}
		}

		result := make([]int, 0, len(left)+len(right))
		for _, d := range left {
			result = append(result, d+1)
		}
		for _, d := range right {
			result = append(result, d+1)
		}

		return result
	}

	dfs(root)
	return count
}