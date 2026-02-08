type ListNode struct {
	Val  int
	Next *ListNode
}

func pairSum(head *ListNode) int {
	slow, fast := head, head
	for fast != nil && fast.Next != nil {
		slow = slow.Next
		fast = fast.Next.Next
	}

	var prev *ListNode
	curr := slow
	for curr != nil {
		next := curr.Next
		curr.Next = prev
		prev = curr
		curr = next
	}

	maxSum := 0
	first, second := head, prev
	for second != nil {
		sum := first.Val + second.Val
		if sum > maxSum {
			maxSum = sum
		}
		first = first.Next
		second = second.Next
	}

	return maxSum
}