type ListNode struct {
    Val  int
    Next *ListNode
}

func deleteMiddle(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return nil
    }

    slow, fast := head, head
    prev := &ListNode{Next: head}

    for fast != nil && fast.Next != nil {
        prev = slow
        slow = slow.Next
        fast = fast.Next.Next
    }

    prev.Next = slow.Next
    return head
}