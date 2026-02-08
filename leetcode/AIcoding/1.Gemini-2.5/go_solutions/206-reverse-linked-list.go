func reverseList(head *ListNode) *ListNode {
    var prev *ListNode = nil
    curr := head

    for curr != nil {
        nextTemp := curr.Next // Store next node
        curr.Next = prev      // Reverse current node's pointer
        prev = curr           // Move prev to current node
        curr = nextTemp       // Move current to next node
    }

    return prev // prev will be the new head of the reversed list
}