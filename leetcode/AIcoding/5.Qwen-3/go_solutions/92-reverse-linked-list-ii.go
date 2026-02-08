package main


func reverseBetween(head *ListNode, m int, n int) *ListNode {
	dummy := &ListNode{Val: 0, Next: head}
	prev := dummy
	for i := 1; i < m; i++ {
		prev = prev.Next
	}
	curr := prev.Next
	for i := m; i < n; i++ {
		next := curr.Next
		curr.Next = next.Next
		next.Next = prev.Next
		prev.Next = next
	}
	return dummy.Next
}