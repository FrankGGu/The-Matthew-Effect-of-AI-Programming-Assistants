import "math"

type ListNode struct {
	Val  int
	Next *ListNode
}

func nodesBetweenCriticalPoints(head *ListNode) []int {
	first, last := -1, -1
	minDist := math.MaxInt32
	prev := head
	curr := head.Next
	idx := 1
	firstIdx := -1
	lastIdx := -1

	for curr != nil && curr.Next != nil {
		next := curr.Next
		if (curr.Val > prev.Val && curr.Val > next.Val) || (curr.Val < prev.Val && curr.Val < next.Val) {
			if firstIdx == -1 {
				firstIdx = idx
				first = idx
			} else {
				minDist = min(minDist, idx-lastIdx)
			}
			lastIdx = idx
			last = idx
		}
		prev = curr
		curr = next
		idx++
	}

	if firstIdx == lastIdx {
		return []int{-1, -1}
	}

	return []int{minDist, last - first}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}