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

    dummy := &Node{}
    stack := []*Node{head}
    curr := dummy

    for len(stack) > 0 {
        node := stack[len(stack)-1]
        stack = stack[:len(stack)-1]

        curr.Next = node
        node.Prev = curr
        curr = curr.Next

        if node.Next != nil {
            stack = append(stack, node.Next)
        }
        if node.Child != nil {
            stack = append(stack, node.Child)
            node.Child = nil
        }
    }

    dummy.Next.Prev = nil
    return dummy.Next
}