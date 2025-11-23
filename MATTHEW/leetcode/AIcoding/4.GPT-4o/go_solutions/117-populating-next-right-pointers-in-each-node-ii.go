type Node struct {
    Val      int
    Left     *Node
    Right    *Node
    Next     *Node
}

func connect(root *Node) *Node {
    if root == nil {
        return root
    }

    queue := []*Node{root}

    for len(queue) > 0 {
        size := len(queue)
        var prev *Node

        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]

            if prev != nil {
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
        prev.Next = nil
    }

    return root
}