func deleteDuplicates(head *ListNode) *ListNode {
    dummy := &ListNode{Val: 0, Next: head}
    prev := dummy
    curr := head

    for curr != nil {