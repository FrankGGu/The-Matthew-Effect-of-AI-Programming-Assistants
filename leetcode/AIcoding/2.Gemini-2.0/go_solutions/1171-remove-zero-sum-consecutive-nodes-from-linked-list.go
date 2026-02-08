type ListNode struct {
	Val  int
	Next *ListNode
}

func removeZeroSumSublists(head *ListNode) *ListNode {
	dummy := &ListNode{Next: head}
	prefixSum := 0
	sumMap := make(map[int]*ListNode)
	sumMap[0] = dummy

	for curr := dummy; curr != nil; curr = curr.Next {
		prefixSum += curr.Val
		if node, ok := sumMap[prefixSum]; ok {
			tempSum := prefixSum
			for temp := node.Next; temp != curr.Next; temp = temp.Next {
				tempSum += temp.Val
				delete(sumMap, tempSum)
			}
			node.Next = curr.Next
		} else {
			sumMap[prefixSum] = curr
		}
	}

	return dummy.Next
}