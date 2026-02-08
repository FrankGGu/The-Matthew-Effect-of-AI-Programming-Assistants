package main


func reorderList(head *ListNode) {
	if head == nil || head.Next == nil {
		return
	}

	// Find the middle of the list
	slow, fast := head, head
	for fast != nil && fast.Next != nil {
		slow = slow.Next
		fast = fast.Next.Next
	}

	// Reverse the second half
	var prev *ListNode
	curr := slow
	for curr != nil {
		next := curr.Next
		curr.Next = prev
		prev = curr
		curr = next
	}

	// Merge the two halves
	first := head
	second := prev
	for second.Next != nil {
		nextFirst := first.Next
		nextSecond := second.Next

		first.Next = second
		second.Next = nextFirst

		first = nextFirst
		second = nextSecond
	}
}