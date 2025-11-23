package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func recoverFromPreorder(traversal string) *TreeNode {
	var i int
	var build func(int) *TreeNode
	build = func(depth int) *TreeNode {
		if i >= len(traversal) {
			return nil
		}
		// Parse the value
		val := 0
		for i < len(traversal) && traversal[i] != '-' {
			val = val*10 + int(traversal[i]-'0')
			i++
		}
		node := &TreeNode{Val: val}
		// Check for depth
		currentDepth := 0
		for i < len(traversal) && traversal[i] == '-' {
			currentDepth++
			i++
		}
		if currentDepth == depth {
			node.Left = build(depth + 1)
			node.Right = build(depth + 1)
		}
		return node
	}
	return build(0)
}