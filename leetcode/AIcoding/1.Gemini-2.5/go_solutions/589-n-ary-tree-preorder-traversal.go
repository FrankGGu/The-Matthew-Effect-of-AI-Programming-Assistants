func preorder(root *Node) []int {
    result := []int{}

    var traverse func(*Node)
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