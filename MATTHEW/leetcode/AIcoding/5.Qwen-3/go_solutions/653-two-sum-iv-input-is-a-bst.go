package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func findTarget(root *TreeNode, k int) bool {
	set := make(map[int]bool)
	return dfs(root, k, set)
}

func dfs(node *TreeNode, k int, set map[int]bool) bool {
	if node == nil {
		return false
	}
	if set[k-node.Val] {
		return true
	}
	set[node.Val] = true
	return dfs(node.Left, k, set) || dfs(node.Right, k, set)
}