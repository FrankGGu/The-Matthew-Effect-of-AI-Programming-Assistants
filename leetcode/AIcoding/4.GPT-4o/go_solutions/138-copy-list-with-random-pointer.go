type Node struct {
    Val    int
    Next   *Node
    Random *Node
}

func copyRandomList(head *Node) *Node {
    if head == nil {
        return nil
    }

    // Step 1: Create a copy of each node and insert them next to the original nodes
    curr := head
    for curr != nil {
        copyNode := &Node{Val: curr.Val}
        copyNode.Next = curr.Next
        curr.Next = copyNode
        curr = copyNode.Next
    }

    // Step 2: Assign random pointers for the copied nodes
    curr = head
    for curr != nil {
        if curr.Random != nil {
            curr.Next.Random = curr.Random.Next
        }
        curr = curr.Next.Next
    }

    // Step 3: Separate the copied list from the original list
    curr = head
    newHead := head.Next
    for curr != nil {
        copyNode := curr.Next
        curr.Next = copyNode.Next
        if copyNode.Next != nil {
            copyNode.Next = copyNode.Next.Next
        }
        curr = curr.Next
    }

    return newHead
}