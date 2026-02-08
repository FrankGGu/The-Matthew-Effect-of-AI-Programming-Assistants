import "sort"

func maxSatisfaction(satisfaction []int) int {
	sort.Ints(satisfaction)
	n := len(satisfaction)
	maxSum := 0
	currentSum := 0
	totalSum := 0
	for i := n - 1; i >= 0; i-- {
		totalSum += satisfaction[i]
		currentSum += totalSum
		maxSum = max(maxSum, currentSum)
	}
	return maxSum
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}