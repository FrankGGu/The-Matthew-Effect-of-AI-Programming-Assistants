package main


func deleteDuplicates(head *ListNode) *ListNode {
    dummy := &ListNode{Val: 0, Next: head}
    prev := dummy
    current := head

    for current != nil {
        if current.Next != nil && current.Val == current.Next.Val {
            for current.Next != nil && current.Val == current.Next.Val {
                current = current.Next
            }
            prev.Next = current.Next
        } else {
            prev = current
        }
        current = current.Next
    }

    return dummy.Next
}