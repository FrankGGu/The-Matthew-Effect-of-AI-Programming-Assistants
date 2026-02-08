package main

type TreeNode struct {
	Val   int
	left  *TreeNode
	right *TreeNode
}

func rootEqualsSumOfChildren(root *TreeNode) bool {
	if root == nil {
		return false
	}
	sum := 0
	if root.left != nil {
		sum += root.left.Val
	}
	if root.right != nil {
		sum += root.right.Val
	}
	return sum == root.Val
}