package main


func rotateRight(head *ListNode, k int) *ListNode {
	if head == nil || head.Next == nil || k == 0 {
		return head
	}

	// Find the length of the list and the tail node
	length := 1
	tail := head
	for tail.Next != nil {
		tail = tail.Next
		length++
	}

	// Compute effective rotation
	k = k % length
	if k == 0 {
		return head
	}

	// Find the new tail and the new head
	newTail := head
	for i := 0; i < length-k-1; i++ {
		newTail = newTail.Next
	}
	newHead := newTail.Next

	// Break the link and connect the tail to the original head
	newTail.Next = nil
	tail.Next = head

	return newHead
}