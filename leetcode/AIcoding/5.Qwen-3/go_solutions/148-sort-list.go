package main


func sortList(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}
	slow, fast := head, head
	for fast.Next != nil && fast.Next.Next != nil {
		slow = slow.Next
		fast = fast.Next.Next
	}
	right := slow.Next
	slow.Next = nil
	left := sortList(head)
	right = sortList(right)
	return merge(left, right)
}

func merge(left, right *ListNode) *ListNode {
	dummy := &ListNode{}
	current := dummy
	for left != nil && right != nil {
		if left.Val <= right.Val {
			current.Next = left
			left = left.Next
		} else {
			current.Next = right
			right = right.Next
		}
		current = current.Next
	}
	if left != nil {
		current.Next = left
	} else {
		current.Next = right
	}
	return dummy.Next
}