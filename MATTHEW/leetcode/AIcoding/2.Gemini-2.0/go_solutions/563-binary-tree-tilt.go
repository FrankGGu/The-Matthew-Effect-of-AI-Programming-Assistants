type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func findTilt(root *TreeNode) int {
	tilt := 0
	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		leftSum := dfs(node.Left)
		rightSum := dfs(node.Right)
		tilt += abs(leftSum - rightSum)
		return leftSum + rightSum + node.Val
	}
	dfs(root)
	return tilt
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}