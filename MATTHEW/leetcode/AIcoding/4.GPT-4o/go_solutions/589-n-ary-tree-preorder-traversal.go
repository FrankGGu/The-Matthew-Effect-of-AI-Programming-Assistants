// Definition for a Node.
type Node struct {
    Val      int
    Children []*Node
}

func preorder(root *Node) []int {
    var result []int
    var traverse func(node *Node)
    traverse = func(node *Node) {
        if node == nil {
            return
        }
        result = append(result, node.Val)
        for _, child := range node.Children {
            traverse(child)
        }
    }
    traverse(root)
    return result
}