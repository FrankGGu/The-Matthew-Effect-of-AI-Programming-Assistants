func reverseKGroup(head *ListNode, k int) *ListNode {
    if head == nil || k <= 1 {
        return head
    }

    dummy := &ListNode{Next: head}
    pre := dummy

    for {
        curr := pre.Next
        tail := pre

        for i := 0; i < k; i++ {
            tail = tail.Next
            if tail == nil {
                return dummy.Next
            }
        }

        nextGroup := tail.Next

        head, tail = reverseList(curr, tail)

        pre.Next = head
        tail.Next = nextGroup
        pre = tail
    }
}

func reverseList(head *ListNode, tail *ListNode) (*ListNode, *ListNode) {
    prev := tail.Next
    curr := head

    for prev != tail {
        next := curr.Next
        curr.Next = prev
        prev = curr
        curr = next
    }

    return tail, head
}