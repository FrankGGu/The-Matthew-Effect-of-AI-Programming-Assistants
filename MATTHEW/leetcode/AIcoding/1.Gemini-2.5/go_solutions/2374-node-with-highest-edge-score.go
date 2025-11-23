func edgeScore(edges []int) int {
	n := len(edges)
	scores := make([]int64, n)

	for i := 0; i < n; i++ {
		targetNode := edges[i]
		scores[targetNode] += int64(i)
	}

	maxScore := int64(-1)
	resultNode := -1

	for i := 0; i < n; i++ {
		if scores[i] > maxScore {
			maxScore = scores[i]
			resultNode = i
		}
	}

	return resultNode
}