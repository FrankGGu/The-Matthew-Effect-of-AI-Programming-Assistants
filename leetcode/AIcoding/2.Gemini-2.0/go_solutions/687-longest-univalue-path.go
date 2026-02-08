type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func longestUnivaluePath(root *TreeNode) int {
	ans := 0
	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		left := dfs(node.Left)
		right := dfs(node.Right)
		arrowLeft := 0
		arrowRight := 0
		if node.Left != nil && node.Left.Val == node.Val {
			arrowLeft += left + 1
		}
		if node.Right != nil && node.Right.Val == node.Val {
			arrowRight += right + 1
		}
		ans = max(ans, arrowLeft+arrowRight)
		return max(arrowLeft, arrowRight)
	}
	dfs(root)
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}