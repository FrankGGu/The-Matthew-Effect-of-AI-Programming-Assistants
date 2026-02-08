func flatten(root *Node) *Node {
    if root == nil {
        return nil
    }

    current := root
    for current != nil {
        if current.Child != nil {
            // Store the next node in the main list
            nextNode := current.Next

            // Find the tail of the child list
            childTail := current.Child
            for childTail.Next != nil {
                childTail = childTail.Next
            }

            // Connect current to its child
            current.Next = current.Child
            current.Child.Prev = current

            // Connect the childTail to the nextNode (if it exists)
            if nextNode != nil {
                childTail.Next = nextNode
                nextNode.Prev = childTail
            }

            // Clear the child pointer
            current.Child = nil
        }
        // Move to the next node in the flattened list
        current = current.Next
    }

    return root
}