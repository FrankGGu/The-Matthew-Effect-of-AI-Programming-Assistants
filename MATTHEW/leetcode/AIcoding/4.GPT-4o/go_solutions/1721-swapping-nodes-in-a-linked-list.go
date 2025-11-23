type ListNode struct {
    Val  int
    Next *ListNode
}

func swapNodes(head *ListNode, k int) *ListNode {
    fast, slow, first, second := head, head, head, head
    for i := 1; i < k; i++ {
        fast = fast.Next
    }
    first = fast
    for fast.Next != nil {
        fast = fast.Next
        slow = slow.Next
    }
    second = slow
    first.Val, second.Val = second.Val, first.Val
    return head
}