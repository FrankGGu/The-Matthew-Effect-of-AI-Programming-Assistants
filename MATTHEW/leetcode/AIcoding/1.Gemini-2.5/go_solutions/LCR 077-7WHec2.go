func sortList(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    slow, fast := head, head
    var prev *ListNode
    for fast != nil && fast.Next != nil {
        prev = slow
        slow = slow.Next
        fast = fast.Next.Next
    }

    if prev != nil {
        prev.Next = nil
    }

    l1 := sortList(head)
    l2 := sortList(slow)

    return mergeTwoLists(l1, l2)
}

func mergeTwoLists(l1 *ListNode, l2 *ListNode) *ListNode {
    dummy := &ListNode{}
    current := dummy

    for l1 != nil && l2 != nil {
        if l1.Val < l2.Val {
            current.Next = l1
            l1 = l1.Next
        } else {
            current.Next = l2
            l2 = l2.Next
        }
        current = current.Next
    }

    if l1 != nil {
        current.Next = l1
    } else if l2 != nil {
        current.Next = l2
    }

    return dummy.Next
}