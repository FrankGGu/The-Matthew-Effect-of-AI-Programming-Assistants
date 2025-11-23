package main


func btreeGameWinningCheck(root *TreeNode) bool {
	var count func(node *TreeNode) int
	count = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		left := count(node.Left)
		right := count(node.Right)
		if left > 0 && right > 0 && (left+right+1)%2 == 0 {
			return 0
		}
		return left + right + 1
	}
	return count(root) != 0
}