type Node struct {
    Val    int
    Prev   *Node
    Next   *Node
    Child  *Node
}

func flatten(head *Node) *Node {
    if head == nil {
        return nil
    }

    pseudoHead := &Node{}
    stack := []*Node{head}
    current := pseudoHead

    for len(stack) > 0 {
        node := stack[len(stack)-1]
        stack = stack[:len(stack)-1]

        current.Next = node
        node.Prev = current
        current = current.Next

        if node.Next != nil {
            stack = append(stack, node.Next)
        }
        if node.Child != nil {
            stack = append(stack, node.Child)
            node.Child = nil
        }
    }

    pseudoHead.Next.Prev = nil
    return pseudoHead.Next
}