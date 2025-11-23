type ListNode struct {
	Val  int
	Next *ListNode
}

func numComponents(head *ListNode, nums []int) int {
	numSet := make(map[int]bool)
	for _, num := range nums {
		numSet[num] = true
	}

	count := 0
	inComponent := false

	for head != nil {
		if _, ok := numSet[head.Val]; ok {
			if !inComponent {
				count++
				inComponent = true
			}
		} else {
			inComponent = false
		}
		head = head.Next
	}

	return count
}