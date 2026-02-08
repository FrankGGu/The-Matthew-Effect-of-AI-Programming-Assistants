type ListNode struct {
    Val  int
    Next *ListNode
}

func deleteDuplicates(head *ListNode) *ListNode {
    dummy := &ListNode{Next: head}
    prev := dummy
    current := head

    for current != nil {
        if current.Next != nil && current.Val == current.Next.Val {
            for current.Next != nil && current.Val == current.Next.Val {
                current = current.Next
            }
            prev.Next = current.Next
        } else {
            prev = prev.Next
        }
        current = current.Next
    }
    return dummy.Next
}