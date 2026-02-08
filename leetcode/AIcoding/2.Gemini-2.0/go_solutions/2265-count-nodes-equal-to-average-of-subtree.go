type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func averageOfSubtree(root *TreeNode) int {
	count := 0
	var dfs func(*TreeNode) (int, int)
	dfs = func(node *TreeNode) (int, int) {
		if node == nil {
			return 0, 0
		}
		sumLeft, numLeft := dfs(node.Left)
		sumRight, numRight := dfs(node.Right)

		sum := sumLeft + sumRight + node.Val
		num := numLeft + numRight + 1

		if sum/num == node.Val {
			count++
		}

		return sum, num
	}

	dfs(root)
	return count
}