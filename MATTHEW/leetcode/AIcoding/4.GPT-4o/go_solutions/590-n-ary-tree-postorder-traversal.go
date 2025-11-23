package main

// Definition for a Node.
type Node struct {
    Val      int
    Children []*Node
}

func postorder(root *Node) []int {
    result := []int{}
    var traverse func(node *Node)
    traverse = func(node *Node) {
        if node == nil {
            return
        }
        for _, child := range node.Children {
            traverse(child)
        }
        result = append(result, node.Val)
    }
    traverse(root)
    return result
}