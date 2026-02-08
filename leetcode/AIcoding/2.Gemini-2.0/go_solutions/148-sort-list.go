type ListNode struct {
	Val  int
	Next *ListNode
}

func sortList(head *ListNode) *ListNode {
	if head == nil || head.Next == nil {
		return head
	}

	slow, fast := head, head.Next
	for fast != nil && fast.Next != nil {
		slow = slow.Next
		fast = fast.Next.Next
	}

	mid := slow.Next
	slow.Next = nil

	left := sortList(head)
	right := sortList(mid)

	return merge(left, right)
}

func merge(left, right *ListNode) *ListNode {
	dummy := &ListNode{}
	tail := dummy

	for left != nil && right != nil {
		if left.Val < right.Val {
			tail.Next = left
			left = left.Next
		} else {
			tail.Next = right
			right = right.Next
		}
		tail = tail.Next
	}

	if left != nil {
		tail.Next = left
	}

	if right != nil {
		tail.Next = right
	}

	return dummy.Next
}