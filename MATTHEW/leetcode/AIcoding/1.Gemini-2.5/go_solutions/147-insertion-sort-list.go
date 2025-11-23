func insertionSortList(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    dummy := &ListNode{