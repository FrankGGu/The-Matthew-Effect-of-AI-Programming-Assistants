func highestEdgeScore(edges []int) int {
	n := len(edges)
	scores := make([]int64, n)
	for i, edge := range edges {
		scores[edge] += int64(i)
	}

	maxScore := int64(-1)
	maxNode := -1

	for i, score := range scores {
		if score > maxScore {
			maxScore = score
			maxNode = i
		}
	}

	return maxNode
}