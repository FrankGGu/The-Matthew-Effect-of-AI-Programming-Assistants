type ListNode struct {
	Val  int
	Next *ListNode
}

func insertGreatestCommonDivisors(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}

	curr := head
	for curr.Next != nil {
		gcdVal := gcd(curr.Val, curr.Next.Val)
		newNode := &ListNode{Val: gcdVal, Next: curr.Next}
		curr.Next = newNode
		curr = curr.Next.Next
	}

	return head
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}