type ListNode struct {
    Val  int
    Next *ListNode
}

func reverseKGroup(head *ListNode, k int) *ListNode {
    dummy := &ListNode{Next: head}
    prevGroupEnd := dummy

    for {
        kth := prevGroupEnd
        for i := 0; i < k; i++ {
            kth = kth.Next
            if kth == nil {
                return dummy.Next
            }
        }
        groupStart := prevGroupEnd.Next
        groupEnd := kth.Next
        kth.Next = nil

        prevGroupEnd.Next = reverseList(groupStart)
        groupStart.Next = groupEnd

        prevGroupEnd = groupStart
    }
}

func reverseList(head *ListNode) *ListNode {
    var prev *ListNode
    curr := head
    for curr != nil {
        next := curr.Next
        curr.Next = prev
        prev = curr
        curr = next
    }
    return prev
}