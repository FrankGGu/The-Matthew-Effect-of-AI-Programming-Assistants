func minimumCost(m int, n int, horizontalCut []int, verticalCut []int) int64 {
	// Sort cuts in descending order
	sort.Sort(sort.Reverse(sort.IntSlice(horizontalCut)))
	sort.Sort(sort.Reverse(sort.IntSlice(