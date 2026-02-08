type ListNode struct {
	Val  int
	Next *ListNode
}

func reverseBetween(head *ListNode, left int, right int) *ListNode {
	if head == nil || head.Next == nil || left == right {
		return head
	}

	dummy := &ListNode{Next: head}
	pre := dummy

	for i := 1; i < left; i++ {
		pre = pre.Next
	}

	curr := pre.Next
	var next *ListNode

	for i := 0; i < right-left; i++ {
		next = curr.Next
		curr.Next = next.Next
		next.Next = pre.Next
		pre.Next = next
	}

	return dummy.Next
}