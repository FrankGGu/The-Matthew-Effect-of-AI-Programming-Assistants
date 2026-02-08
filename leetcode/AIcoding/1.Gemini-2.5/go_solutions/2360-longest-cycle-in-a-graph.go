func longestCycle(edges []int) int {
	n := len(edges)
	visitedGlobal := make([]bool, n) // Tracks nodes visited in any traversal
	maxCycleLen := -1

	for i := 0; i < n; i++ {
		if !visitedGlobal[i] {
			// For each new