type ListNode struct {
    Val  int
    Next *ListNode
}

func isPalindrome(head *ListNode) bool {
    if head == nil {
        return true
    }

    slow, fast := head, head
    var prev *ListNode

    for fast != nil && fast.Next != nil {
        fast = fast.Next.Next
        slowNext := slow.Next
        slow.Next = prev
        prev = slow
        slow = slowNext
    }

    if fast != nil {
        slow = slow.Next
    }

    for prev != nil && slow != nil {
        if prev.Val != slow.Val {
            return false
        }
        prev = prev.Next
        slow = slow.Next
    }

    return true
}