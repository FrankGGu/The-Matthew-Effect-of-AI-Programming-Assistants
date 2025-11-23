func reorderList(head *ListNode) {
	if head == nil || head.Next == nil {
		return
	}

	// 1. Find the middle of the list
	// slow will point to the head of the second half
	// prevSlow will point to the tail of the first half
	var prevSlow *ListNode
	slow, fast := head, head
	for fast != nil && fast.Next != nil {
		prevSlow = slow
		slow = slow.Next
		fast = fast.Next.Next
	}

	// Split the list into two halves
	// firstHalfHead = head
	// secondHalfHead = slow
	if prevSlow != nil {
		prevSlow.Next = nil // Break the link to separate the two halves
	}

	// 2. Reverse the second half
	var prev *ListNode
	curr := slow // slow is the head of the second half
	for curr != nil {
		nextTemp := curr.Next
		curr.Next = prev
		prev = curr
		curr = nextTemp
	}
	// prev is now the head of the reversed second half

	// 3. Merge the two halves alternately
	p1 := head // Head of the first half
	p2 := prev // Head of the reversed second half

	for p2 != nil { // The second half (reversed) will always be shorter or equal in length
		temp1 := p1.Next
		temp2 := p2.Next

		p1.Next = p2
		p2.Next = temp1

		p1 = temp1
		p2 = temp2
	}
}