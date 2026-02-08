import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func maxSumBST(root *TreeNode) int {
	maxSum := 0
	var dfs func(*TreeNode) (bool, int, int, int)

	dfs = func(node *TreeNode) (bool, int, int, int) {
		if node == nil {
			return true, math.MaxInt32, math.MinInt32, 0
		}

		isLeftBST, leftMin, leftMax, leftSum := dfs(node.Left)
		isRightBST, rightMin, rightMax, rightSum := dfs(node.Right)

		if isLeftBST && isRightBST && node.Val > leftMax && node.Val < rightMin {
			sum := leftSum + rightSum + node.Val
			maxSum = max(maxSum, sum)
			return true, min(leftMin, node.Val), max(rightMax, node.Val), sum
		}

		return false, 0, 0, 0
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

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}