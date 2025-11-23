type ListNode struct {
	Val  int
	Next *ListNode
}

func splitListToParts(head *ListNode, k int) []*ListNode {
	length := 0
	curr := head
	for curr != nil {
		length++
		curr = curr.Next
	}

	baseSize := length / k
	remainder := length % k

	result := make([]*ListNode, k)
	curr = head
	for i := 0; i < k; i++ {
		result[i] = curr
		partSize := baseSize
		if i < remainder {
			partSize++
		}

		if partSize > 0 {
			for j := 1; j < partSize; j++ {
				curr = curr.Next
			}
			next := curr.Next
			curr.Next = nil
			curr = next
		} else {
			curr = nil
		}
	}

	return result
}