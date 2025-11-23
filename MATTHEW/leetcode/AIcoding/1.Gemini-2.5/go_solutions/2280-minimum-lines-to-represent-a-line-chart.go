import "sort"

func minimumLines(stockPrices [][]int) int {
	n := len(stockPrices)
	if n <= 1 {
		return 0
	}

	sort.Slice(stockPrices, func(i, j int) bool {
		return stockPrices[i][0] < stockPrices[j][0]
	})

	lines := 1
	for i := 2; i < n; i++ {
		p1 := stockPrices[i-2]
		p2 := stockPrices[i-1]
		p3 := stockPrices[i]

		// Check collinearity using cross-product method to avoid division and float issues
		// (y2 - y1) * (x3 - x2) == (y3 - y2) * (x2 - x1)
		// Using int64 for calculations to prevent potential overflow
		if (int64(p2[1])-int64(p1[1]))*(int64(p3[0])-int64(p2[0])) != (int64(p3[1])-int64(p2[1]))*(int64(p2[0])-int64(p1[0])) {
			lines++
		}
	}

	return lines
}