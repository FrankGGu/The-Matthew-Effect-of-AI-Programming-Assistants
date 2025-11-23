func minCost(colors string, neededTime []int) int {
	totalCost := 0
	n := len(colors)
	if n <= 1 {
		return 0
	}

	i := 0
	for i < n {
		j := i
		currentSum := 0
		current