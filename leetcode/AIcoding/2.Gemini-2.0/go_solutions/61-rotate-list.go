type ListNode struct {
	Val  int
	Next *ListNode
}

func rotateRight(head *ListNode, k int) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}

	length := 0
	curr := head
	for curr != nil {
		length++
		curr = curr.Next
	}

	k = k % length
	if k == 0 {
		return head
	}

	curr = head
	for i := 0; i < length-k-1; i++ {
		curr = curr.Next
	}

	newHead := curr.Next
	curr.Next = nil

	curr = newHead
	for curr.Next != nil {
		curr = curr.Next
	}

	curr.Next = head

	return newHead
}