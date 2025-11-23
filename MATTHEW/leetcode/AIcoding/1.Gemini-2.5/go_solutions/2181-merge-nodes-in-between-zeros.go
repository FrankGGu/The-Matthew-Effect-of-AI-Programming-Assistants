func mergeNodes(head *ListNode) *ListNode {
    // Create a dummy head for the new merged list.
    // This simplifies handling the first node of the result.
    dummyHead := &