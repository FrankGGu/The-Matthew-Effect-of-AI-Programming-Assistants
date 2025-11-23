package main


func evaluateTree(root *TreeNode) bool {
	if root == nil {
		return false
	}
	if root.Val == 0 || root.Val == 1 {
		return root.Val == 1
	}
	left := evaluateTree(root.Left)
	right := evaluateTree(root.Right)
	if root.Val == 2 {
		return left || right
	}
	return left && right
}