import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func maxPathSum(root *TreeNode) int {
	maxSum := math.MinInt32
	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		leftSum := max(0, dfs(node.Left))
		rightSum := max(0, dfs(node.Right))
		maxSum = max(maxSum, leftSum+rightSum+node.Val)
		return max(leftSum, rightSum) + node.Val
	}
	dfs(root)
	return maxSum
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}