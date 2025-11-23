func flatten(root *Node) *Node {
    if root == nil {
        return nil
    }

    curr := root

    for curr != nil {
        if curr.Child == nil {
            curr = curr.Next
        } else {
            child := curr.Child
            tail := child

            for tail.Next != nil {
                tail = tail.Next
            }

            tail.Next = curr.Next

            if curr.Next != nil {
                curr.Next.Prev = tail
            }

            curr.Next = child
            child.Prev = curr
            curr.Child = nil
            curr = curr.Next
        }
    }

    return root
}