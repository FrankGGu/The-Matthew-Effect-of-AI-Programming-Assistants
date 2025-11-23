func maxDepth(root *Node) int {
    if root == nil {
        return 0
    }

    maxChildDepth := 0
    for _, child := range root.Children {
        childDepth := maxDepth(child)
        if childDepth > maxChildDepth {
            maxChildDepth = childDepth
        }
    }

    return 1 + maxChildDepth
}