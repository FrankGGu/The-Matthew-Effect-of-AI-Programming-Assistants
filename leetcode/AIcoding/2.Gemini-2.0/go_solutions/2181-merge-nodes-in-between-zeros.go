type ListNode struct {
	Val  int
	Next *ListNode
}

func mergeNodes(head *ListNode) *ListNode {
	dummy := &ListNode{}
	curr := dummy
	sum := 0
	for head != nil {
		if head.Val == 0 {
			if sum != 0 {
				curr.Next = &ListNode{Val: sum}
				curr = curr.Next
				sum = 0
			}
		} else {
			sum += head.Val
		}
		head = head.Next
	}
	return dummy.Next
}