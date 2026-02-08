func maxDepth(root *Node) int {
    if root == nil {
        return 0
    }

    maxChildDepth := 0
    for _, child := range root.Children {
        depth := maxDepth(child)
        if depth > maxChildDepth {
            maxChildDepth = depth
        }
    }

    return maxChildDepth + 1
}