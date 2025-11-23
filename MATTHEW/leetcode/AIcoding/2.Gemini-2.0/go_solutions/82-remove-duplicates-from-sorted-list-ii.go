type ListNode struct {
	Val  int
	Next *ListNode
}

func deleteDuplicates(head *ListNode) *ListNode {
	dummy := &ListNode{Next: head}
	prev := dummy
	curr := head

	for curr != nil {
		if curr.Next != nil && curr.Val == curr.Next.Val {
			for curr.Next != nil && curr.Val == curr.Next.Val {
				curr = curr.Next
			}
			prev.Next = curr.Next
			curr = curr.Next
		} else {
			prev = curr
			curr = curr.Next
		}
	}

	return dummy.Next
}