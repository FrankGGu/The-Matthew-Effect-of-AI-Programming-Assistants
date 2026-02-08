func swapPairs(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}

	dummy := &ListNode{Val: 0, Next: head}
	prev := dummy

	for prev.Next != nil && prev.Next.Next != nil {
		first := prev.Next
		second := prev.Next.Next

		// Swap the two nodes
		first.Next = second.Next
		second.Next = first
		prev.Next = second

		// Move prev to the next pair
		prev = first
	}

	return dummy.Next
}