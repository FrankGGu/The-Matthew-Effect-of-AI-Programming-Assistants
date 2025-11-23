type ListNode struct {
	Val  int
	Next *ListNode
}

func doubleIt(head *ListNode) *ListNode {
	carry := 0
	dummy := &ListNode{Next: head}
	curr := dummy

	var reverse func(*ListNode) *ListNode
	reverse = func(node *ListNode) *ListNode {
		var prev *ListNode
		curr := node
		for curr != nil {
			next := curr.Next
			curr.Next = prev
			prev = curr
			curr = next
		}
		return prev
	}

	head = reverse(head)
	curr = head

	for curr != nil {
		sum := curr.Val*2 + carry
		curr.Val = sum % 10
		carry = sum / 10
		curr = curr.Next
	}

	head = reverse(head)

	if carry > 0 {
		dummy.Val = carry
		return dummy
	}

	return head
}