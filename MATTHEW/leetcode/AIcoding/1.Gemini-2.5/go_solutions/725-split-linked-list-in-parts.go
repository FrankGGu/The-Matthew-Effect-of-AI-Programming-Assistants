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
		if remainder > 0 {
			partSize++
			remainder--
		}

		var prev *ListNode
		for j := 0; j < partSize; j++ {
			prev = curr
			if curr != nil {
				curr = curr.Next
			}
		}

		if prev != nil {
			prev.Next = nil
		}
	}

	return result
}