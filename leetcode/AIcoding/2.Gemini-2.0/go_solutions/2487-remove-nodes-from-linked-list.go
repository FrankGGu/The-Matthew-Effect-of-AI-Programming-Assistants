type ListNode struct {
	Val  int
	Next *ListNode
}

func removeNodes(head *ListNode) *ListNode {
	stack := []*ListNode{}
	curr := head

	for curr != nil {
		for len(stack) > 0 && stack[len(stack)-1].Val < curr.Val {
			stack = stack[:len(stack)-1]
		}
		stack = append(stack, curr)
		curr = curr.Next
	}

	if len(stack) == 0 {
		return nil
	}

	head = stack[0]
	curr = head
	for i := 1; i < len(stack); i++ {
		curr.Next = stack[i]
		curr = curr.Next
	}
	curr.Next = nil

	return head
}