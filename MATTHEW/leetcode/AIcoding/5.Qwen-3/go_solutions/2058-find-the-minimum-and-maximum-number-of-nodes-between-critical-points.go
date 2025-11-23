package main


func nodesBetweenCriticalPoints(head *ListNode) []int {
	var criticalIndices []int
	prev := head
	curr := head.Next
	index := 1
	for curr.Next != nil {
		if (curr.Val > prev.Val && curr.Val > curr.Next.Val) || (curr.Val < prev.Val && curr.Val < curr.Next.Val) {
			criticalIndices = append(criticalIndices, index)
		}
		prev = curr
		curr = curr.Next
		index++
	}

	if len(criticalIndices) < 2 {
		return []int{-1, -1}
	}

	minDistance := criticalIndices[1] - criticalIndices[0]
	maxDistance := criticalIndices[len(criticalIndices)-1] - criticalIndices[0]

	for i := 1; i < len(criticalIndices); i++ {
		minDistance = min(minDistance, criticalIndices[i]-criticalIndices[i-1])
	}

	return []int{minDistance, maxDistance}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}