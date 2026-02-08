package main

import (
	"sort"
)

func minimumLines(stockPrices [][]int) int {
	sort.Slice(stockPrices, func(i, j int) bool {
		return stockPrices[i][0] < stockPrices[j][0]
	})

	count := 0
	n := len(stockPrices)

	if n <= 1 {
		return 0
	}

	for i := 1; i < n-1; i++ {
		x1, y1 := stockPrices[i-1][0], stockPrices[i-1][1]
		x2, y2 := stockPrices[i][0], stockPrices[i][1]
		x3, y3 := stockPrices[i+1][0], stockPrices[i+1][1]

		if (y2-y1)*(x3-x2) != (y3-y2)*(x2-x1) {
			count++
		}
	}
	return count + 1
}