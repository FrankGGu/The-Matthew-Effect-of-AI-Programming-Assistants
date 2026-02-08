func trainingPlan(head *ListNode, k int) *ListNode {
	slow, fast := head, head
	for i := 0; i < k; i++ {
		fast = fast.Next
	}
	if fast == nil {
		return head.Next
	}

	for fast.Next != nil {
		slow = slow.Next
		fast = fast.Next
	}

	node := slow.Next
	slow.Next = slow.Next.Next
	fast.Next = head
	return node
}