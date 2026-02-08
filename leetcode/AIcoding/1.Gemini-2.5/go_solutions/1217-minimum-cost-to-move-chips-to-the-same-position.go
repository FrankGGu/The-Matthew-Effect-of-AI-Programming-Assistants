package main

import "math"

func minCostToMoveChips(chips []int) int {
	evenCount := 0
	oddCount := 0
	for _, pos := range chips {
		if pos%2 == 0 {
			evenCount++
		} else {
			oddCount++
		}
	}
	return int(math.Min(float64(evenCount), float64(oddCount)))
}