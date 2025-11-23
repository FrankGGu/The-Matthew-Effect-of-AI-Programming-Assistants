package main


func reverseKGroup(head *ListNode, k int) *ListNode {
    dummy := &ListNode{Val: 0, Next: head}
    prev := dummy
    curr := head

    for curr != nil {
        var tail *ListNode = prev
        for i := 0; i < k; i++ {
            tail = tail.Next
            if tail == nil {
                return dummy.Next
            }
        }

        nextGroup := tail.Next
        prev.Next = reverse(curr, tail)
        curr.Next = nextGroup

        prev = curr
        curr = nextGroup
    }

    return dummy.Next
}

func reverse(a, b *ListNode) *ListNode {
    var prev *ListNode = nil
    curr := a
    for curr != b {
        next := curr.Next
        curr.Next = prev
        prev = curr
        curr = next
    }
    return prev
}