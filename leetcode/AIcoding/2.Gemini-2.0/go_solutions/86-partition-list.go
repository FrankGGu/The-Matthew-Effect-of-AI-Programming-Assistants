type ListNode struct {
	Val  int
	Next *ListNode
}

func partition(head *ListNode, x int) *ListNode {
	lessHead := &ListNode{}
	greaterHead := &ListNode{}
	lessTail := lessHead
	greaterTail := greaterHead

	for head != nil {
		if head.Val < x {
			lessTail.Next = head
			lessTail = lessTail.Next
		} else {
			greaterTail.Next = head
			greaterTail = greaterTail.Next
		}
		head = head.Next
	}

	greaterTail.Next = nil
	lessTail.Next = greaterHead.Next

	return lessHead.Next
}