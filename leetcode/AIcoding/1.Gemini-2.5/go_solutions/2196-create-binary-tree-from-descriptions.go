func createBinaryTree(descriptions [][]int) *TreeNode {
    nodes := make(map[int]*TreeNode)
    children := make(map[int]bool)

    for _, desc := range descriptions {
        parentVal, childVal, isLeft := desc[0], desc[1], desc[2]

        // Get or create parent node
        parent, ok := nodes[parentVal]
        if !ok {
            parent = &TreeNode{Val: parentVal}
            nodes[parentVal] = parent
        }

        // Get or create child node
        child, ok := nodes[childVal]
        if !ok {
            child = &TreeNode{Val: childVal}
            nodes[childVal] = child
        }

        // Link parent and child
        if isLeft == 1 {
            parent.Left = child
        } else {
            parent.Right = child
        }

        // Mark childVal as a child
        children[childVal] = true
    }

    // Find the root node
    // The root node is the one that is never a child
    for val, node := range nodes {
        if _, isChild := children[val]; !isChild {
            return node
        }
    }

    return nil // Should not happen based on problem constraints
}