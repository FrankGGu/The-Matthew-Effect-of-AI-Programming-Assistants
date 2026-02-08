func reorderList(head *ListNode) {
    if head == nil || head.Next == nil {
        return
    }

    slow := head
    fast := head
    var prev *ListNode

    for fast != nil && fast.Next != nil {
        prev = slow
        slow = slow.Next
        fast = fast.Next.Next
    }

    if prev != nil {
        prev.Next = nil
    }

    secondHalfHead := reverseList(slow)

    mergeLists(head, secondHalfHead)
}

func reverseList(head *ListNode) *ListNode {
    var prev *ListNode
    curr := head
    for curr != nil {
        nextTemp := curr.Next
        curr.Next = prev
        prev = curr
        curr = nextTemp
    }
    return prev
}

func mergeLists(l1 *ListNode, l2 *ListNode) {
    for l1 != nil && l2 != nil {
        l1_next_temp := l1.Next
        l2_next_temp := l2.Next

        l1.Next = l2
        if l1_next_temp != nil {
            l2.Next = l1_next_temp
        } else {
            l2.Next = l2_next_temp
        }

        l1 = l1_next_temp
        l2 = l2_next_temp
    }
}