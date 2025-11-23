func isCompleteTree(root *TreeNode) bool {
    if root == nil {
        return true
    }

    queue := []*TreeNode{root}
    foundNil := false

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]

        if node == nil {
            foundNil = true
        } else {
            if foundNil {
                return false
            }
            queue = append(queue, node.Left)
            queue = append(queue, node.Right)
        }
    }

    return true
}