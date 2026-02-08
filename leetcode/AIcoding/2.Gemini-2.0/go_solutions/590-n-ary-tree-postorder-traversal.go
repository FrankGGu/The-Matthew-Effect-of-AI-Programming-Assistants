func postorder(root *Node) []int {
    res := []int{}
    var traverse func(*Node)
    traverse = func(node *Node) {
        if node == nil {
            return
        }
        for _, child := range node.Children {
            traverse(child)
        }
        res = append(res, node.Val)
    }
    traverse(root)
    return res
}