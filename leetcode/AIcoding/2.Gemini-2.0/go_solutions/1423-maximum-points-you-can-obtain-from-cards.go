func maxScore(cardPoints []int, k int) int {
	n := len(cardPoints)
	totalSum := 0
	for _, point := range cardPoints {
		totalSum += point
	}

	windowSize := n - k
	currentSum := 0
	for i := 0; i < windowSize; i++ {
		currentSum += cardPoints[i]
	}

	minSum := currentSum
	for i := windowSize; i < n; i++ {
		currentSum += cardPoints[i] - cardPoints[i-windowSize]
		if currentSum < minSum {
			minSum = currentSum
		}
	}

	return totalSum - minSum
}