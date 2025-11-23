func reorderList(head *ListNode) {
	if head == nil || head.Next == nil {
		return
	}

	// Find middle
	slow, fast := head, head
	for fast != nil && fast.Next != nil {
		slow = slow.Next
		fast = fast.Next.Next
	}

	// Reverse second half
	secondHalf := slow.Next
	slow.Next = nil
	var prev *ListNode
	curr := secondHalf
	for curr != nil {
		next := curr.Next
		curr.Next = prev
		prev = curr
		curr = next
	}

	// Merge two halves
	firstHalf := head
	secondHalf = prev
	for secondHalf != nil {
		temp1 := firstHalf.Next
		temp2 := secondHalf.Next
		firstHalf.Next = secondHalf
		secondHalf.Next = temp1
		firstHalf = temp1
		secondHalf = temp2
	}
}