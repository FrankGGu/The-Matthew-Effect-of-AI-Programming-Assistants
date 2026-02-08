package main


func maxSumBST(root *TreeNode) int {
	var result int

	var dfs func(*TreeNode) (bool, int, int, int)
	dfs = func(node *TreeNode) (bool, int, int, int) {
		if node == nil {
			return true, 0, math.MaxInt32, math.MinInt32
		}

		leftValid, leftSum, leftMin, leftMax := dfs(node.Left)
		rightValid, rightSum, rightMin, rightMax := dfs(node.Right)

		if leftValid && rightValid && node.Val > leftMax && node.Val < rightMin {
			currentSum := leftSum + rightSum + node.Val
			currentMin := min(leftMin, node.Val)
			currentMax := max(rightMax, node.Val)
			result = max(result, currentSum)
			return true, currentSum, currentMin, currentMax
		}

		return false, 0, 0, 0
	}

	dfs(root)
	return result
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