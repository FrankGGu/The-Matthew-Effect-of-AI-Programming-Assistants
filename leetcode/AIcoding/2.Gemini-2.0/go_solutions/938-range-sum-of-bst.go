type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func rangeSumBST(root *TreeNode, low int, high int) int {
	sum := 0
	var dfs func(node *TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			return
		}
		if node.Val >= low && node.Val <= high {
			sum += node.Val
		}
		if node.Val > low {
			dfs(node.Left)
		}
		if node.Val < high {
			dfs(node.Right)
		}
	}
	dfs(root)
	return sum
}