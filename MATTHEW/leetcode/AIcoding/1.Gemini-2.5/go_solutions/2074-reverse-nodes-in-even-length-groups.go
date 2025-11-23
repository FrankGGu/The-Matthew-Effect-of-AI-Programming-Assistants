func reverseEvenLengthGroups(head *ListNode) *ListNode {
    dummy := &ListNode{Next: head}
    prevGroupEnd := dummy
    groupNum := 1

    for prevGroupEnd.Next != nil {
        currentGroupStart := prevGroupEnd.Next

        // Find the end of the current group and count its actual length
        curr := currentGroupStart
        groupLength := 0
        var currentGroupEnd *ListNode // This will be the last node of the current group

        for i := 0; i < groupNum && curr != nil; i++ {
            currentGroupEnd = curr
            curr = curr.Next
            groupLength++
        }
        // At this point:
        // currentGroupStart is the first node of the group
        // currentGroupEnd is the last node of the group
        // curr is the node *after* the group (nextGroupStart)

        if groupLength%2 == 0 {
            // Reverse the group
            // 'prev' will be the head of the reversed segment
            // 'curr' (from the loop above) is already nextGroupStart
            prev := curr // This is the node that the last node of the current group should point to after reversal
            segmentCurr := currentGroupStart
            for i := 0; i < groupLength; i++ {
                nextTemp := segmentCurr.Next
                segmentCurr.Next = prev
                prev = segmentCurr
                segmentCurr = nextTemp
            }
            // After reversal:
            // 'prev' is the new head of the reversed group
            // 'currentGroupStart' (original start) is now the tail of the reversed group

            prevGroupEnd.Next = prev // Connect the node before the group to the new head
            prevGroupEnd = currentGroupStart // The original start (now tail) becomes the new prevGroupEnd
        } else {
            // Group length is odd, no reversal needed
            // Move prevGroupEnd to the end of the current group
            prevGroupEnd = currentGroupEnd
        }
        groupNum++
    }

    return dummy.Next
}