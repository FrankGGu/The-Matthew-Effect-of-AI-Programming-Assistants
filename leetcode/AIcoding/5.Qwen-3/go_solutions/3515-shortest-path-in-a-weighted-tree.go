package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func shortestPathSum(root *TreeNode) int {
	if root == nil {
		return 0
	}
	if root.Left == nil && root.Right == nil {
		return root.Val
	}
	left := shortestPathSum(root.Left)
	right := shortestPathSum(root.Right)
	if left < right {
		return root.Val + left
	}
	return root.Val + right
}