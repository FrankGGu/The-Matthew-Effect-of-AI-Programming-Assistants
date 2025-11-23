package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func diameterOfBinaryTree(root *TreeNode) int {
	if root == nil {
		return 0
	}
	var diameter int
	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		left := dfs(node.Left)
		right := dfs(node.Right)
		diameter = max(diameter, left+right)
		return 1 + max(left, right)
	}
	dfs(root)
	return diameter
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}