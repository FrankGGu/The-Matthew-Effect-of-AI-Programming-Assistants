func addOneRow(root *TreeNode, val int, depth int) *TreeNode {
    if depth == 1 {
        newNode := &TreeNode{Val: val, Left: root}
        return newNode
    }

    var queue []*TreeNode
    queue = append(queue, root)
    level := 1

    for len(queue) > 0 && level < depth-1 {
        size := len(queue)
        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        level++
    }

    for _, node := range queue {
        leftNode := &TreeNode{Val: val, Left: node.Left}
        rightNode := &TreeNode{Val: val, Right: node.Right}
        node.Left = leftNode
        node.Right = rightNode
    }

    return root
}