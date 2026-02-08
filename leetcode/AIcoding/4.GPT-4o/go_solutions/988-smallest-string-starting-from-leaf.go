package main

import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func smallestFromLeaf(root *TreeNode) string {
	var dfs func(node *TreeNode, path string) string
	dfs = func(node *TreeNode, path string) string {
		if node == nil {
			return ""
		}
		path = string('a'+node.Val) + path
		if node.Left == nil && node.Right == nil {
			return path
		}
		left := dfs(node.Left, path)
		right := dfs(node.Right, path)
		if left == "" {
			return right
		}
		if right == "" {
			return left
		}
		if left < right {
			return left
		}
		return right
	}
	return dfs(root, "")
}