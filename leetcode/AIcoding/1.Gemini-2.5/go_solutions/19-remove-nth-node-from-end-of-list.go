func removeNthFromEnd(head *ListNode, n int) *ListNode {
    dummy := &ListNode{Val: 0, Next: head}
    slow := dummy
    fast := dummy

    for i := 0; i <= n; i++ {
        fast = fast.Next
    }

    for fast != nil {
        slow = slow.Next
        fast = fast.Next
    }

    slow.Next = slow.Next.Next

    return dummy.Next
}