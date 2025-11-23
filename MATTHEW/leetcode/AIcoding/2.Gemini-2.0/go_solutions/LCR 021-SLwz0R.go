func removeNthFromEnd(head *ListNode, n int) *ListNode {
    dummy := &ListNode{Next: head}
    first := dummy
    second := dummy

    for i := 1; i <= n+1; i++ {
        if first == nil {
            return head.Next
        }
        first = first.Next
    }

    for first != nil {
        first = first.Next
        second = second.Next
    }

    second.Next = second.Next.Next

    return dummy.Next
}