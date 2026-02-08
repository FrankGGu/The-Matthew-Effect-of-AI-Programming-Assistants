type ListNode struct {
    Val  int
    Next *ListNode
}

func sortList(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    // Find the middle of the list
    slow, fast := head, head
    var prev *ListNode
    for fast != nil && fast.Next != nil {
        prev = slow
        slow = slow.Next
        fast = fast.Next.Next
    }
    prev.Next = nil // Split the list into two halves

    left := sortList(head)
    right := sortList(slow)

    return merge(left, right)
}

func merge(l1, l2 *ListNode) *ListNode {
    dummy := &ListNode{}
    tail := dummy

    for l1 != nil && l2 != nil {
        if l1.Val < l2.Val {
            tail.Next = l1
            l1 = l1.Next
        } else {
            tail.Next = l2
            l2 = l2.Next
        }
        tail = tail.Next
    }
    if l1 != nil {
        tail.Next = l1
    }
    if l2 != nil {
        tail.Next = l2
    }
    return dummy.Next
}