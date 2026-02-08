func reverseKGroup(head *ListNode, k int) *ListNode {
    if head == nil || k == 1 {
        return head
    }

    dummy := &ListNode{Val: 0, Next: head}
    prevGroupTail := dummy

    for {
        // 1. Check if there are k nodes remaining for the current group
        groupHead := prevGroupTail.Next
        if groupHead == nil {
            break // No more nodes to process
        }

        groupTail := groupHead
        count := 1
        for count < k && groupTail != nil {
            groupTail = groupTail.Next
            count++
        }

        if groupTail == nil {
            // Not enough nodes for a full k-group, leave remaining as is
            break
        }

        // 2. Store the head of the next group and detach the current k-group
        nextGroupHead := groupTail.Next
        groupTail.Next = nil // Detach the k-group from the rest of the list

        // 3. Reverse the k-group
        // The `reverseList` function takes the head of the sublist and returns its new head.
        // The original `groupHead` will become the new tail of the reversed group.
        newGroupHead := reverseList(groupHead)

        // 4. Connect the reversed k-group back to the main list
        prevGroupTail.Next = newGroupHead // Connect the previous part to the new head of the reversed group
        groupHead.Next = nextGroupHead     // Connect the new tail of the reversed group (original groupHead) to the next part of the list

        // 5. Update prevGroupTail for the next iteration
        // The original groupHead is now the tail of the reversed group,
        // and will be the `prevGroupTail` for the next k-group.
        prevGroupTail = groupHead 
    }

    return dummy.Next
}

func reverseList(head *ListNode) *ListNode {
    var prev *ListNode
    curr := head
    for curr != nil {
        nextTemp := curr.Next
        curr.Next = prev
        prev = curr
        curr = nextTemp
    }
    return prev
}