package main


func insertGreatestCommonDivisors(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}

	current := head
	for current.Next != nil {
		a := current.Val
		b := current.Next.Val
		gcd := func(x, y int) int {
			for y != 0 {
				x, y = y, x%y
			}
			return x
		}(a, b)
		newNode := &ListNode{Val: gcd, Next: current.Next}
		current.Next = newNode
		current = newNode.Next
	}

	return head
}