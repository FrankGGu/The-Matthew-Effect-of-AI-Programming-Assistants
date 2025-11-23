func reverseBetween(head *ListNode, m int, n int) *ListNode {
	if head == nil || m == n {
		return head
	}

	dummy := &ListNode{Val: 0, Next: head}
	preM := dummy

	// Move preM to the node before the m-th node
	for i := 0; i < m-1; i++ {
		preM = preM.Next
	}

	// startM is the m-th node, which will become the tail of the reversed sublist
	startM := preM.Next

	// current will iterate from m+1 to n
	// prev will be the previously reversed node
	prev := startM
	current := startM.Next

	// Reverse the sublist from m to n
	// We need to perform n-m reversals
	for i := 0; i < n-m; i++ {
		nextTemp := current.Next
		current.Next = prev
		prev = current
		current = nextTemp
	}

	// Connect the three parts of the list
	// 1. The node before the sublist (preM) points to the new head of the reversed sublist (prev)
	preM.Next = prev
	// 2. The original m-th node (startM) points to the node after the reversed sublist (current)
	startM.Next = current

	return dummy.Next
}