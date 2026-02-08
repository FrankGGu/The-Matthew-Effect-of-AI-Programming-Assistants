func detectCycle(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return nil
	}

	slow := head
	fast := head

	// Phase 1: Detect cycle and find the meeting point
	for fast != nil && fast.Next != nil {
		slow = slow.Next
		fast = fast.Next.Next

		if slow == fast {
			// Cycle detected. Phase 2: Find the start of the cycle.
			// Reset one pointer to the head and move both pointers one step at a time.
			// They will meet at the starting node of the cycle.
			slow = head