type ListNode struct {
    Val  int
    Next *ListNode
}

func insertionSortList(head *ListNode) *ListNode {
    if head == nil {
        return head
    }

    dummy := &ListNode{0, nil}
    curr := head

    for curr != nil {
        prev := dummy
        next := curr.Next

        for prev.Next != nil && prev.Next.Val < curr.Val {
            prev = prev.Next
        }

        curr.Next = prev.Next
        prev.Next = curr
        curr = next
    }

    return dummy.Next
}