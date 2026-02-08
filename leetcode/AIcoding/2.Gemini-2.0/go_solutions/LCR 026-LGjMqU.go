type ListNode struct {
	Val  int
	Next *ListNode
}

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
	var prev *ListNode = nil
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
		firstNext := firstHalf.Next
		secondNext := secondHalf.Next

		firstHalf.Next = secondHalf
		secondHalf.Next = firstNext

		firstHalf = firstNext
		secondHalf = secondNext
	}
}