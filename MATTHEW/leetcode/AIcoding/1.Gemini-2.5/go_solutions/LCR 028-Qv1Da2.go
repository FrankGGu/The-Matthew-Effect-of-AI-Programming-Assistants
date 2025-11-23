type Node struct {
    Val   int
    Prev  *Node
    Next  *Node
    Child *Node
}

func flatten(root *Node) *Node {
    if root == nil {
        return nil
    }
    flattenAndReturnTail(root)
    return root
}

func flattenAndReturnTail(node *Node) *Node {
    curr := node
    var tail *Node

    for curr != nil {
        tail = curr // Keep track of the current node as the potential tail

        if curr.Child != nil {
            // Store the original next node in the main list
            tempNext := curr.Next

            // Connect current node to its child
            curr.Next = curr.Child
            curr.Child.Prev = curr

            // Recursively flatten the child list and get its ultimate tail
            // curr.Next now points to the child's head
            childTail := flattenAndReturnTail(curr.Next) 

            // Connect the child's flattened tail to the original next node (if it exists)
            if tempNext != nil {
                childTail.Next = tempNext
                tempNext.Prev = childTail
            }

            // Clear the child pointer as it's now part of the main list
            curr.Child = nil
        }
        curr = curr.Next // Move to the next node in the current flattened sequence
    }
    return tail // Return the last node encountered in this segment
}