func minimumCost(m int, n int, horizontalCut []int, verticalCut []int) int64 {
	// Sort cuts in descending order
	sort.Slice(horizontalCut, func(i, j int) bool {
		return horizontalCut[i] > horizontalCut[j]
	})