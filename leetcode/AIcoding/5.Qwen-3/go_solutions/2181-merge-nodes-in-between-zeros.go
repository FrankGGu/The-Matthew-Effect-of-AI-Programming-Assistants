package main


func mergeNodes(head *ListNode) *ListNode {
	dummy := &ListNode{}
	current := dummy
	sum := 0
	head = head.Next
	for head != nil {
		if head.Val == 0 {
			current.Next = &ListNode{Val: sum}
			current = current.Next
			sum = 0
		} else {
			sum += head.Val
		}
		head = head.Next
	}
	return dummy.Next
}