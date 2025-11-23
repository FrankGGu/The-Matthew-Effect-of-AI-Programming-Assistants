type ListNode struct {
    Val  int
    Next *ListNode
}

func pairSum(head *ListNode) int {
    slow, fast := head, head
    var prev *ListNode

    for fast != nil && fast.Next != nil {
        fast = fast.Next.Next
        slowNext := slow.Next
        slow.Next = prev
        prev = slow
        slow = slowNext
    }

    maxSum := 0
    for prev != nil {
        maxSum = max(maxSum, prev.Val+slow.Val)
        prev = prev.Next
        slow = slow.Next
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}