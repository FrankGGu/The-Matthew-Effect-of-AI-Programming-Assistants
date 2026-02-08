type ListNode struct {
	Val  int
	Next *ListNode
}

func reverseEvenLengthGroups(head *ListNode) *ListNode {
	dummy := &ListNode{Next: head}
	curr := dummy
	groupLen := 1

	for curr.Next != nil {
		var groupHead *ListNode = curr.Next
		var groupTail *ListNode = curr
		count := 0

		for i := 0; i < groupLen; i++ {
			if groupTail.Next == nil {
				break
			}
			groupTail = groupTail.Next
			count++
		}

		var nextGroupHead *ListNode = groupTail.Next

		if count%2 == 0 {
			var prev *ListNode = nextGroupHead
			var current *ListNode = groupHead
			for current != nextGroupHead {
				next := current.Next
				current.Next = prev
				prev = current
				current = next
			}

			curr.Next = prev
			groupHead.Next = nextGroupHead
			curr = groupHead

		} else {
			curr = groupTail
		}
		groupLen++
	}

	return dummy.Next
}