package main

type ListNode struct {
	Val  int
	next *ListNode
}

func doubleIt(head *ListNode) *ListNode {
	if head == nil {
		return nil
	}

	var prev *ListNode
	curr := head

	for curr != nil {
		newVal := curr.Val * 2
		if newVal > 9 {
			if prev != nil {
				prev.Val++
			} else {
				head = &ListNode{Val: 1, next: head}
				prev = head
			}
		}
		curr.Val = newVal % 10
		prev = curr
		curr = curr.next
	}

	return head
}