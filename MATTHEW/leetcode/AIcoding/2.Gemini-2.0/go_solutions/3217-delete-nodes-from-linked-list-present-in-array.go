type ListNode struct {
	Val  int
	Next *ListNode
}

func deleteNodes(head *ListNode, val []int) *ListNode {
	valSet := make(map[int]bool)
	for _, v := range val {
		valSet[v] = true
	}

	dummy := &ListNode{Next: head}
	curr := dummy

	for curr != nil && curr.Next != nil {
		if _, ok := valSet[curr.Next.Val]; ok {
			curr.Next = curr.Next.Next
		} else {
			curr = curr.Next
		}
	}

	return dummy.Next
}