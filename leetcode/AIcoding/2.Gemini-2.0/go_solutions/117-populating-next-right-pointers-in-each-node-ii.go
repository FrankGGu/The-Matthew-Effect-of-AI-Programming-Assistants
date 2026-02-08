func connect(root *Node) *Node {
    if root == nil {
        return nil
    }

    queue := []*Node{root}

    for len(queue) > 0 {
        size := len(queue)
        var prev *Node

        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]

            if i > 0 {
                prev.Next = node
            }

            prev = node

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
    }

    return root
}