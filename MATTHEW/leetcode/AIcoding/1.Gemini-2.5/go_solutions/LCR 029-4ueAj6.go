func insert(head *Node, insertVal int) *Node {
    newNode := &Node{Val: insertVal}

    if head == nil {
        newNode.Next = newNode
        return newNode
    }

    curr := head
    // Loop until we find an insertion point or complete a full cycle
    for {
        next := curr.Next

        // Case 1: Standard insertion point
        // curr.Val <= insertVal <= next.Val
        if curr.Val <= insertVal && insertVal <= next.Val {
            break
        }

        // Case 2: Wrap-around point (curr is max, next is min)
        // Insert if insertVal is greater than max or less than min
        if curr.Val > next.Val { // This indicates the "break" point in the sorted cycle
            if insertVal >= curr.Val || insertVal <= next.Val {
                break
            }
        }

        curr = curr.Next
        // If we've completed a full cycle and haven't found an insertion point,
        // it means all elements in the list are identical.
        // In this scenario, we can insert the new node anywhere,
        // for example, between the current `curr` and `curr.Next`.
        // The loop will eventually bring `curr` back to the starting `head`.
        // If `curr` is `head` again and no `break` has occurred, it means
        // none of the specific sorted conditions were met, implying all values are the same.
        if curr == head {
            break
        }
    }

    // Insert newNode between curr and curr.Next
    newNode.Next = curr.Next
    curr.Next = newNode

    return head
}