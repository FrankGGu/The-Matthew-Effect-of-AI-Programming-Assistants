func hIndex(citations []int) int {
	sort.Ints(citations)
	n := len(citations)

	for h := n; h >= 0; h-- {
		// If h is 0, it means 0 papers have at least 0 citations. This is always true