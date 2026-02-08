package main

type Node struct {
	Val      int
	Children []*Node
}

func postorder(root *Node) []int {
	result := []int{}
	var dfs func(*Node)
	dfs = func(node *Node) {
		if node == nil {
			return
		}
		for _, child := range node.Children {
			dfs(child)
		}
		result = append(result, node.Val)
	}
	dfs(root)
	return result
}