func postorder(root *Node) []int {
    var result []int
    traverse(root, &result)
    return result
}

func traverse(node *Node, result *[]int) {
    if node == nil {
        return
    }

    for _, child := range node.Children {
        traverse(child, result)
    }

    *result = append(*result, node.Val)
}