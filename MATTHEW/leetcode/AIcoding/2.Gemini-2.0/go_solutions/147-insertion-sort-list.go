type ListNode struct {
	Val  int
	Next *ListNode
}

func insertionSortList(head *ListNode) *ListNode {
	dummyHead := &ListNode{Next: head}
	lastSorted := head
	curr := head.Next

	for curr != nil {
		if curr.Val >= lastSorted.Val {
			lastSorted = curr
			curr = curr.Next
		} else {
			prev := dummyHead
			for prev.Next.Val <= curr.Val {
				prev = prev.Next
			}

			lastSorted.Next = curr.Next

			curr.Next = prev.Next
			prev.Next = curr

			curr = lastSorted.Next
		}
	}

	return dummyHead.Next
}