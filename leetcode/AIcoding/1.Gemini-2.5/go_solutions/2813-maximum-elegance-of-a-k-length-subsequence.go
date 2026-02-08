func findMaximumElegance(items [][]int, k int) int64 {
	// Sort items by profit in descending order
	sort.Slice(items, func(i, j int) bool {
		return items[i][0] > items[j][0]
	})