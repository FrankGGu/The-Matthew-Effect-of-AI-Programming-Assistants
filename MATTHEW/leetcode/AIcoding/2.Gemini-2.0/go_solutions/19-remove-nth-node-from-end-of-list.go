type ListNode struct {
	Val  int
	Next *ListNode
}

func removeNthFromEnd(head *ListNode, n int) *ListNode {
	dummy := &ListNode{0, head}
	first := dummy
	second := head

	for i := 0; i < n; i++ {
		second = second.Next
	}

	for second != nil {
		first = first.Next
		second = second.Next
	}

	first.Next = first.Next.Next

	return dummy.Next
}