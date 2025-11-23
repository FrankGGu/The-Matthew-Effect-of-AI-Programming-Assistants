package main


func lcaDeepestLeaves(root *TreeNode) *TreeNode {
	if root == nil {
		return nil
	}
	left := lcaDeepestLeaves(root.Left)
	right := lcaDeepestLeaves(root.Right)
	if left == nil {
		return right
	}
	if right == nil {
		return left
	}
	return root
}