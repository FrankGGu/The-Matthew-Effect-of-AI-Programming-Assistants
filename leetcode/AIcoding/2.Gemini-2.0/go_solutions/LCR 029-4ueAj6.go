type ListNode struct {
	Val  int
	Next *ListNode
}

func insert(head *ListNode, insertVal int) *ListNode {
	newNode := &ListNode{Val: insertVal}
	if head == nil {
		newNode.Next = newNode
		return newNode
	}

	curr := head
	for {
		if curr.Val <= insertVal && insertVal <= curr.Next.Val ||
			(curr.Val > curr.Next.Val && (insertVal >= curr.Val || insertVal <= curr.Next.Val)) ||
			curr.Next == head {
			newNode.Next = curr.Next
			curr.Next = newNode
			return head
		}
		curr = curr.Next
	}
}