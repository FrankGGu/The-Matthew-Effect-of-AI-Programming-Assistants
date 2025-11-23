package main

type Node struct {
	Val      int
	Children []*Node
}

func maxDepth(root *Node) int {
	if root == nil {
		return 0
	}
	maxChildDepth := 0
	for _, child := range root.Children {
		currentDepth := maxDepth(child)
		if currentDepth > maxChildDepth {
			maxChildDepth = currentDepth
		}
	}
	return maxChildDepth + 1
}