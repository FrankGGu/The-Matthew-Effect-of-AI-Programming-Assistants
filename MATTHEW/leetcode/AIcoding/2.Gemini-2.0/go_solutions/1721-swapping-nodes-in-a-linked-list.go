type ListNode struct {
	Val  int
	Next *ListNode
}

func swapNodes(head *ListNode, k int) *ListNode {
	first := head
	for i := 1; i < k; i++ {
		first = first.Next
	}

	second := head
	tail := first
	for tail.Next != nil {
		second = second.Next
		tail = tail.Next
	}

	first.Val, second.Val = second.Val, first.Val
	return head
}