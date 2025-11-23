package main

type Node struct {
	Val      int
	Children []*Node
}

func preorder(root *Node) []*int {
	result := []*int{}
	if root == nil {
		return result
	}
	result = append(result, &root.Val)
	for _, child := range root.Children {
		result = append(result, preorder(child)...)
	}
	return result
}