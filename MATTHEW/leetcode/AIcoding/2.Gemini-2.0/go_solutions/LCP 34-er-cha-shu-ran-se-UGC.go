type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func btreeGameWinningMove(root *TreeNode, n int, x int) bool {
	var left, right int
	var find func(*TreeNode) int
	find = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		l := find(node.Left)
		r := find(node.Right)
		if node.Val == x {
			left = l
			right = r
		}
		return l + r + 1
	}
	find(root)
	parent := n - left - right - 1
	return parent > left+right+1 || left > parent+right+1 || right > parent+left+1
}