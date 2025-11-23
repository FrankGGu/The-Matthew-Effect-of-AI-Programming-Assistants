package main


func insertionSortList(head *ListNode) *ListNode {
    dummy := &ListNode{}
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