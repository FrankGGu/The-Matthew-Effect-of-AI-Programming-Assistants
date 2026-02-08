type ListNode struct {
    Val  int
    Next *ListNode
}

func removeZeroSumSublists(head *ListNode) *ListNode {
    dummy := &ListNode{Val: 0, Next: head}
    prefixSum := make(map[int]*ListNode)
    current := dummy
    sum := 0

    for current != nil {
        sum += current.Val
        prefixSum[sum] = current
        current = current.Next
    }

    current = dummy
    sum = 0

    for current != nil {
        sum += current.Val
        current.Next = prefixSum[sum].Next
        current = current.Next
    }

    return dummy.Next
}