package main

// Definition for a Node.
type Node struct {
    Val      int
    Children []*Node
}

func maxDepth(root *Node) int {
    if root == nil {
        return 0
    }
    depth := 0
    for _, child := range root.Children {
        childDepth := maxDepth(child)
        if childDepth > depth {
            depth = childDepth
        }
    }
    return depth + 1
}