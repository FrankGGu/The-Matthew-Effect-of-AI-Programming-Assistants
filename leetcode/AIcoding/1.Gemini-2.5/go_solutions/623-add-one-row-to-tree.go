func addOneRow(root *TreeNode, val int, depth int) *TreeNode {
    if depth == 1 {
        newRoot := &TreeNode{Val: val}
        newRoot.Left = root
        return newRoot
    }

    queue := []*TreeNode{root}
    currentDepth := 1

    for currentDepth < depth - 1 {
        levelSize := len(queue)
        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        currentDepth++
    }

    for _, node := range queue {
        originalLeft := node.Left
        newLeft := &TreeNode{Val: val}
        newLeft.Left = originalLeft
        node.Left = newLeft

        originalRight := node.Right
        newRight := &TreeNode{Val: val}
        newRight.Right = originalRight
        node.Right = newRight
    }

    return root
}